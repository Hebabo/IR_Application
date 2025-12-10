import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/onboarding_model.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPageItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 330,
          width: 330,
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

        const SizedBox(height: 40),

        // Title
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            model.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}