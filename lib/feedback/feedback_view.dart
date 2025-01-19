import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_styles.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blueColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'FeedBack',
          style: AppStyles.bold22.copyWith(
            color: AppColors.blueColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please write your feedback..!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            //const Spacer(flex: 2,),
            //const Gap(20),
            const SizedBox(
              height: 35,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email Address',
                filled: true,
                fillColor: const Color(0xffd9d9d9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Subject',
                filled: true,
                fillColor: const Color(0xffd9d9d9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Feedback...',
                filled: true,
                fillColor: const Color(0xffd9d9d9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(
              height: 30,
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0062ff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'submit',
                      style: AppStyles.regular18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
