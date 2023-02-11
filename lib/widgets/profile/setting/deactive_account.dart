import 'package:flutter/material.dart';

import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_textformfield.dart';
import '../../custom_widgets/cutom_text.dart';
import 'delete_account_widget.dart';

class DeleteAccount extends StatelessWidget {
  DeleteAccount({super.key});
  final TextEditingController _selectReason = TextEditingController();
  final TextEditingController _anythingElse = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: _selectReason,
              hint: 'Select Reason',
              color: const Color(0xffF6F7F9),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: _anythingElse,
              hint: 'write something to improve our app',
              color: const Color(0xffF6F7F9),
              maxLength: 7,
              maxLines: 7,
            ),
            const Spacer(),
            CustomElevatedButton(
              title: 'Delete my Acoount',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const Dialog(
                    child: DeleteAccountWidget(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbarWidget(BuildContext context) {
    return AppBar(
      title: const ForText(
        name: 'Delete your account',
        bold: true,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
    );
  }
}
