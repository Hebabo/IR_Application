import 'package:flutter/material.dart';

class DocumentContentField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final int maxLines;

  const DocumentContentField({
    super.key,
    required this.controller,
    this.enabled = true,
    this.maxLines = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: 'Enter your document content here',
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: const TextStyle(
          fontSize: 15,
          height: 1.5,
        ),
      ),
    );
  }
}