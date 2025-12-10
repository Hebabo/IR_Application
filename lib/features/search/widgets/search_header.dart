import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/features/search/widgets/search_text_field.dart';
import 'package:information_retrieval/features/search/widgets/search_method_dropdown.dart';

class SearchHeader extends StatelessWidget {
  final TextEditingController searchController;
  final SearchMethod selectedMethod;
  final VoidCallback onSearch;
  final VoidCallback onClear;
  final ValueChanged<SearchMethod> onMethodChanged;

  const SearchHeader({
    super.key,
    required this.searchController,
    required this.selectedMethod,
    required this.onSearch,
    required this.onClear,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field
          SearchTextField(
            controller: searchController,
            onSubmitted: onSearch,
            onClear: onClear,
          ),

          const SizedBox(height: 16),

          // Method Dropdown
          SearchMethodDropdown(
            selectedMethod: selectedMethod,
            onChanged: onMethodChanged,
          ),
        ],
      ),
    );
  }
}