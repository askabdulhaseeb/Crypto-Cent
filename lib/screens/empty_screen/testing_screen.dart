import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../providers/rating_provider.dart';
import '../../widgets/custom_widgets/custom_dialog.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_review_dialoge.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              title: 'title',
              onTap: () async{
                   await HapticFeedback.heavyImpact();
                alertBox(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> alertBox(
    BuildContext context,
  ) async {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          return Consumer<RatingProvider>(
              builder: (BuildContext context, RatingProvider ratingPro, _) {
            //return const CustomReviewDialogBox();
            return AlertDialog(
              title: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Product name'),
                    ],
                  ),
                  ratingBar(ratingPro),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: CustomTextFormField(
                controller: ratingPro.ratingComment,
                hint: 'Comment',
                maxLength: 500,
                maxLines: 5,
              ),
              actions: [
                CustomElevatedButton(title: 'Done', onTap: () async{await HapticFeedback.heavyImpact();}),
              ],
            );
          });
        });
  }

  RatingBar ratingBar(RatingProvider ratingPro) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (BuildContext context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (double rating) {
        ratingPro.rating = rating;
      },
    );
  }
}
