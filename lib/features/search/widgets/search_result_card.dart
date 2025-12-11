import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/core/utils/text_highlighter.dart';

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
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
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

            // Content with highlighted search terms (excluding stop words)
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