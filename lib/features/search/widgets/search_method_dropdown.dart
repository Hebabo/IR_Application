import 'package:flutter/material.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchMethodDropdown extends StatelessWidget {
  final SearchMethod selectedMethod;
  final ValueChanged<SearchMethod> onChanged;

  const SearchMethodDropdown({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  String _getMethodDisplayName(SearchMethod method) {
    switch (method) {
      case SearchMethod.invertedIndex:
        return 'Inverted Index';
      case SearchMethod.positionalIndex:
        return 'Positional Index';
      case SearchMethod.soundex:
        return 'Soundex';
    }
  }

  IconData _getMethodIcon(SearchMethod method) {
    switch (method) {
      case SearchMethod.invertedIndex:
        return Icons.list_alt;
      case SearchMethod.positionalIndex:
        return Icons.location_on_outlined;
      case SearchMethod.soundex:
        return Icons.hearing;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SearchMethod>(
          value: selectedMethod,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.white,
          menuMaxHeight: 300.h,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.sp,
          ),
          items: SearchMethod.values.map((method) {
            return DropdownMenuItem(
              value: method,
              child: Row(
                children: [
                  Icon(
                    _getMethodIcon(method),
                    size: 20.sp,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 12.w),
                  Text(_getMethodDisplayName(method)),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ),
    );
  }
}