import 'package:flutter/material.dart';
import 'package:information_retrieval/core/widgets/default_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultAnimation(),
          SizedBox(height: 16.h),
          Text(
            'Start searching',
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter a query and select a search method',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}