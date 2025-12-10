import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/features/search/widgets/search_result_card.dart';
import 'package:information_retrieval/features/search/widgets/processing_steps_card.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;
  final List<String> processingSteps;
  final int totalResults;

  const SearchResultsList({
    super.key,
    required this.results,
    this.processingSteps = const [],
    this.totalResults = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search query',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: results.length + 2, // +2 for header and processing steps
      itemBuilder: (context, index) {
        // Results header
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Found $totalResults ${totalResults == 1 ? 'result' : 'results'}',
            ),
          );
        }
        
        // Processing steps
        if (index == 1) {
          return ProcessingStepsCard(steps: processingSteps);
        }
        
        // Results
        final resultIndex = index - 2;
        if (resultIndex < results.length) {
          final result = results[resultIndex];
          return SearchResultCard(result: result);
        }
        return const SizedBox.shrink();
      },
    );
  }
}