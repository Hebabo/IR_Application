import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/features/search/widgets/search_result_card.dart';
import 'package:information_retrieval/features/search/widgets/processing_steps_card.dart';
import 'package:information_retrieval/features/search/widgets/suggested_terms_list.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;
  final List<String> processingSteps;
  final int totalResults;
  final List<String>? suggestedTerms;
  final String query;
  final Function(String)? onSuggestedTermTap;

  const SearchResultsList({
    super.key,
    required this.results,
    this.processingSteps = const [],
    this.totalResults = 0,
    this.suggestedTerms,
    required this.query,
    this.onSuggestedTermTap,
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

    // Calculate item count: header + processing + suggested terms (if any) + results
    int itemCount = 2 + results.length; // header + processing + results
    if (suggestedTerms != null && suggestedTerms!.isNotEmpty) {
      itemCount++; // +1 for suggested terms row
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        int currentIndex = index;

        // Results header
        if (currentIndex == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Found $totalResults ${totalResults == 1 ? 'result' : 'results'}',
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        }
        currentIndex--;

        // Processing steps
        if (currentIndex == 0) {
          return ProcessingStepsCard(steps: processingSteps);
        }
        currentIndex--;

        // Suggested terms (only for Soundex)
        if (suggestedTerms != null && suggestedTerms!.isNotEmpty && currentIndex == 0) {
          return SuggestedTermsList(
            suggestedTerms: suggestedTerms!,
            onTermTap: onSuggestedTermTap,
          );
        }
        if (suggestedTerms != null && suggestedTerms!.isNotEmpty) {
          currentIndex--;
        }

        // Results
        if (currentIndex < results.length) {
          final result = results[currentIndex];
          return SearchResultCard(
            result: result,
            searchQuery: query,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}