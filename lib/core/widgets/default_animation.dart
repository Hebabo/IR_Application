import 'package:flutter/material.dart';
import 'package:information_retrieval/core/const/assets_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DefaultAnimation extends StatelessWidget {
  final double maxHeight;

  const DefaultAnimation({
    super.key,
    this.maxHeight = 260,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight.h, 
      child: Center(
        child: Image.asset(
          AnimationAssets.defaultSearch,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
