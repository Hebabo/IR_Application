import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/core/utils/text_highlighter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultCard extends StatelessWidget {
  final SearchResult result;
  final String? searchQuery;

  const SearchResultCard({
    super.key,
    required this.result,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "${result.title}:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),

            // Content with highlighted search terms 
            RichText(
              text: TextSpan(
                children: TextHighlighter.buildHighlightedText(
                  result.snippet,
                  searchQuery,
                  excludeStopWords: true,
                  normalTextColor: Colors.grey[700],
                  highlightColor: Colors.yellow[300],
                  highlightTextColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}