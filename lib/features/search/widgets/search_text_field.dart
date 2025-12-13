import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;
  final VoidCallback onClear;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onClear,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: widget.controller,
        onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
        onSubmitted: (_) => widget.onSubmitted(),
        decoration: InputDecoration(
          hintText: 'Enter search query',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: widget.onSubmitted,
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.grey[600]),
                  onPressed: widget.onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
        onChanged: (value) {
          setState(() {}); // Rebuild to show/hide clear button
        },
      ),
    );
  }
}