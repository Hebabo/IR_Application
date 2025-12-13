import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // Detect if keyboard is open
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    
    return Container(
      color: Colors.white,
      // Reduce padding when keyboard is open
      padding: EdgeInsets.fromLTRB(
        20.w, 
        0, 
        20.w, 
        keyboardOpen ? 8.h : 20.h, // Less padding when keyboard open
      ),
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

          SizedBox(height: keyboardOpen ? 8.h : 16.h), // Less space when keyboard open

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