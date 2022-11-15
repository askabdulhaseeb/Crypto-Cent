import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../database/databse_storage.dart';
import '../../database/product_api.dart';
import '../../function/time_date_function.dart';
import '../../models/categories/categories.dart';
import '../../models/categories/sub_categories.dart';
import '../../models/product_model.dart';
import '../../providers/categories_provider.dart';
import '../../utilities/image_picker.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

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

  Uint8List? _image;
  bool _isloading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> uploaddata(CategoriesProvider catPro) async {
    if (_formKey.currentState!.validate() && _image != null) {
      setState(() {
        _isloading = true;
      });
      String imageurl = await Storagemethod().uploadtostorage(
        'post',
        'tester',
        _image!,
      );

      Product product = Product(
        pid: TimeStamp.timestamp.toString(),
        amount: double.parse(amount.text),
        colors: '',
        quantity: quantity.text,
        productname: productname.text,
        description: productdecription.text,
        timestamp: TimeStamp.timestamp,
        category: catPro.currentCat!.catID,
        subCategory: catPro.subcurrentCat!.catID,
        createdByUID: 'tester',
        imageurl: imageurl,
      );
      bool temp = await ProductApi().add(product);
      if (temp) {
        CustomToast.successToast(message: 'upload');
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

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: _image != null
                      ? GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(_image!))),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(
                                      Icons.add_circle_outline_outlined,
                                      color: Colors.white,
                                      size: 36),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const ForText(
                                  name: 'Add Image',
                                  color: Colors.white,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: productname,
                  hint: 'Enter Product Name',
                  maxLength: 160,
                  readOnly: _isloading,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                CustomTextFormField(
                  controller: productdecription,
                  hint: 'Enter Product Description',
                  maxLines: 5,
                  readOnly: _isloading,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                CustomTextFormField(
                  controller: amount,
                  hint: 'Enter Product Price',
                  readOnly: _isloading,
                  validator: (String? value) => CustomValidator.isEmpty(value),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                ),
                CustomTextFormField(
                  controller: quantity,
                  hint: 'Enter Product Quantity',
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
        border: Border.all(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
        ),
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
        border: Border.all(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
        ),
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
          // starticon: Icons.person,
          hint: hint,
          validator: (String? value) => CustomValidator.isEmpty(value),
        ),
      ],
    );
  }
}
