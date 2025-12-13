import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/onboarding_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPageItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 330.h,
          width: 330.w,
          decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.05),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(model.imagePath),
                width: 660, // 2x for high-DPI screens
                height: 660,
              ),
              fit: BoxFit.cover,
            ),
          ),
          // clipBehavior: Clip.antiAlias,
          // child: Image.asset(
          //   model.imagePath,
          //   fit: BoxFit.cover,
          // ),
        ),

        SizedBox(height: 40.h),

        // Title
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 12.h),

        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.h),
          child: Text(
            model.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black54,
              height: 1.4.h,
            ),
          ),
        ),

        SizedBox(height: 30.h),
      ],
    );
  }
}
