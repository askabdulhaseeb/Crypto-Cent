import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/databse_storage.dart';
import '../../database/product_api.dart';
import '../../function/attachment_picker.dart';
import '../../function/time_date_function.dart';
import '../../function/unique_id_functions.dart';
import '../../models/categories/categories.dart';
import '../../models/categories/sub_categories.dart';
import '../../models/product/product_model.dart';
import '../../models/product/product_url.dart';
import '../../providers/categories_provider.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../../widgets/product/get_product_attachments.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productname = TextEditingController();
  final TextEditingController productdecription = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController quantity = TextEditingController();

  List<File?> _files = <File?>[
    null,
    null,
    null,
    null,
  ];
  bool _isloading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> uploaddata(CategoriesProvider catPro) async {
    if (_formKey.currentState!.validate() && _files[0] != null) {
      setState(() {
        _isloading = true;
      });
      final List<ProductURL> urls = <ProductURL>[];
      for (int i = 0; _files[i] != null; i++) {
        String imageurl = await Storagemethod().uploadtostorage(
          'post',
          'tester',
          file: _files[i],
        );
        urls.add(ProductURL(url: imageurl, isVideo: false, index: i));
      }

      Product product = Product(
        pid: UniqueIdFunctions.postID,
        uid: AuthMethods.uid,
        amount: double.parse(amount.text),
        colors: '',
        quantity: quantity.text,
        productname: productname.text,
        description: productdecription.text,
        timestamp: TimeStamp.timestamp,
        category: catPro.currentCat!.catID,
        subCategory: catPro.subcurrentCat!.catID,
        createdByUID: AuthMethods.uid,
        prodURL: urls,
      );
      bool temp = await ProductApi().add(product);
      if (temp) {
        CustomToast.alertDialogeBox(context: context, text: 'upload');

        _files = <File?>[
          null,
          null,
          null,
          null,
        ];
        productname.clear();
        productdecription.clear();
        amount.clear();

        quantity.clear();
      }
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoriesProvider catPro = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Upload')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                GetProductAttachments(
                    file: _files,
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            ListTile(
                              onTap: () async {
                                final List<File?> temp =
                                    await AttachmentPicker().camera();
                                if (temp[0] == null) return;
                                setState(() {
                                  _files = temp;
                                });
                                if (!mounted) return;
                                Navigator.of(context).pop();
                              },
                              leading: const Icon(Icons.photo_camera),
                              title: const Text('Camera'),
                              subtitle: const Text(
                                'Click here to click images from device Camera',
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                final List<File?> temp =
                                    await AttachmentPicker().multiImage();
                                if (temp[0] == null) return;
                                setState(() {
                                  _files = temp;
                                });
                                if (!mounted) return;
                                Navigator.of(context).pop();
                              },
                              leading: const Icon(Icons.photo_rounded),
                              title: const Text('Gallery'),
                              subtitle: const Text(
                                  'Click here to choose images from gallery'),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    }),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: productname,
                  hint: 'Enter Name',
                  readOnly: _isloading,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                CustomTextFormField(
                  controller: productdecription,
                  hint: 'Enter Description',
                  maxLines: 5,
                  maxLength: 2000,
                  readOnly: _isloading,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                CustomTextFormField(
                  controller: amount,
                  hint: 'Enter Price',
                  readOnly: _isloading,
                  validator: (String? value) => CustomValidator.isEmpty(value),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                ),
                CustomTextFormField(
                  controller: quantity,
                  hint: 'Enter Quantity',
                  readOnly: _isloading,
                  validator: (String? value) => CustomValidator.isEmpty(value),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                ),
                const SizedBox(height: 6),
                categorie(context, catPro),
                const SizedBox(height: 12),
                subCategorie(context, catPro),
                const SizedBox(height: 20),
                _isloading
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                        title: 'Upload',
                        onTap: () async => await uploaddata(catPro),
                      ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categorie(BuildContext context, CategoriesProvider catPro) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                child: Text('Categories'),
              ),
            ),
          ),
          const Spacer(),
          DropdownButton<Categories>(
            value: catPro.currentCat,
            style: const TextStyle(color: Colors.black),
            underline: const SizedBox(),
            hint: const Text(
              'Category',
              style: TextStyle(color: Colors.black),
            ),
            items: catPro.categories
                .map((Categories cats) => DropdownMenuItem<Categories>(
                      value: cats,
                      child: Text(
                        cats.title.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
                .toList(),
            onChanged: (Categories? value) => catPro.formValueChange(value!),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget subCategorie(BuildContext context, CategoriesProvider catPro) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                child: Text('Sub Categories'),
              ),
            ),
          ),
          const Spacer(),
          DropdownButton<SubCategory>(
            value: catPro.subcurrentCat,
            style: const TextStyle(color: Colors.black),
            underline: const SizedBox(),
            hint: const Text(
              'Sub Category',
              style: TextStyle(color: Colors.black),
            ),
            items: catPro.subCa
                .map((SubCategory subcats) => DropdownMenuItem<SubCategory>(
                      value: subcats,
                      child: Text(
                        subcats.title.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
                .toList(),
            onChanged: (SubCategory? value) => catPro.subCategoryChange(value!),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget textField(
      BuildContext context, TextEditingController controller, String hint) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: controller,
          hint: hint,
          validator: (String? value) => CustomValidator.isEmpty(value),
        ),
      ],
    );
  }
}
