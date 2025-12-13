import 'package:flutter/material.dart';
import 'package:information_retrieval/core/const/assets_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailLoadingAnimation extends StatelessWidget {
  final double maxHeight;

  const FailLoadingAnimation({
    super.key,
    this.maxHeight = 280,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight.h, 
      child: Center(
        child: Image.asset(
          AnimationAssets.searchFail,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
