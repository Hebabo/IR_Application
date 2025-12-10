import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/search_model.dart';

class SearchResultCard extends StatelessWidget {
  final SearchResult result;
  final String? searchQuery;

  const SearchResultCard({
    super.key,
    required this.result,
    this.searchQuery,
  });

  // Function to highlight search terms in text
  List<TextSpan> _buildHighlightedText(String text, String? query) {
    if (query == null || query.isEmpty) {
      return [
        TextSpan(
          text: text,
          style: TextStyle(
            color: Colors.grey[700],
            height: 1.4,
          ),
        ),
      ];
    }

    final List<TextSpan> spans = [];
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final queryWords = lowerQuery.split(' ');

    int currentIndex = 0;

    while (currentIndex < text.length) {
      int nearestMatch = -1;
      int matchLength = 0;

      // Find the nearest match of any query word
      for (final word in queryWords) {
        if (word.isEmpty) continue;

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
              color: Colors.grey[700],
              height: 1.4,
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
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        );
      }

      // Add highlighted match
      spans.add(
        TextSpan(
          text: text.substring(nearestMatch, nearestMatch + matchLength),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.yellow[300],
            height: 1.4,
          ),
        ),
      );

      currentIndex = nearestMatch + matchLength;
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "${result.title}:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),

            // Content with highlighted search terms
            RichText(
              text: TextSpan(
                children: _buildHighlightedText(result.snippet, searchQuery),
              ),
            ),
          ],
        ),
      ),
    );
  }
}