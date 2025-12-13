import 'package:flutter/material.dart';
import 'package:information_retrieval/core/utils/stop_words.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextHighlighter {
  static List<TextSpan> buildHighlightedText(
    String text,
    String? query, {
    bool excludeStopWords = true,
    Color? normalTextColor,
    Color? highlightColor,
    Color? highlightTextColor,
  }) {
    // Default colors
    normalTextColor ??= Colors.grey[700]!;
    highlightColor ??= const Color.fromARGB(255, 118, 237, 255);
    highlightTextColor ??= Colors.black;

    if (query == null || query.isEmpty) {
      return [
        TextSpan(
          text: text,
          style: TextStyle(
            color: normalTextColor,
            height: 1.4.h,
          ),
        ),
      ];
    }

    final List<TextSpan> spans = [];
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    
    // Split query into words and filter out stop words if needed
    final queryWords = lowerQuery.split(' ').where((word) {
      if (word.isEmpty) return false;
      if (excludeStopWords && StopWords.isStopWord(word)) return false;
      return true;
    }).toList();

    // If no valid words to highlight, return normal text
    if (queryWords.isEmpty) {
      return [
        TextSpan(
          text: text,
          style: TextStyle(
            color: normalTextColor,
            height: 1.4.h,
          ),
        ),
      ];
    }

    int currentIndex = 0;

    while (currentIndex < text.length) {
      int nearestMatch = -1;
      int matchLength = 0;

      // Find the nearest match of any query word
      for (final word in queryWords) {
        final index = lowerText.indexOf(word, currentIndex);
        if (index != -1 && (nearestMatch == -1 || index < nearestMatch)) {
          nearestMatch = index;
          matchLength = word.length;
        }
      }

      if (nearestMatch == -1) {
        // No more matches, add remaining text
        spans.add(
          TextSpan(
            text: text.substring(currentIndex),
            style: TextStyle(
              color: normalTextColor,
              height: 1.4.h,
            ),
          ),
        );
        break;
      }

      // Add text before match
      if (nearestMatch > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, nearestMatch),
            style: TextStyle(
              color: normalTextColor,
              height: 1.4.h,
            ),
          ),
        );
      }

      // Add highlighted match
      spans.add(
        TextSpan(
          text: text.substring(nearestMatch, nearestMatch + matchLength),
          style: TextStyle(
            color: highlightTextColor,
            fontWeight: FontWeight.bold,
            backgroundColor: highlightColor,
            height: 1.4.h,
          ),
        ),
      );

      currentIndex = nearestMatch + matchLength;
    }

    return spans;
  }
}