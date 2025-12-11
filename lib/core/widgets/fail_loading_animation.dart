
// Step 3: Create a reusable LoadingAnimation widget
import 'package:flutter/material.dart';
import 'package:information_retrieval/core/const/assets_manager.dart';

class FailLoadingAnimation extends StatelessWidget {
  final double size;

  const FailLoadingAnimation({
    super.key,
    this.size = 280,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AnimationAssets.searchFail,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}