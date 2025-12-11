import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:information_retrieval/features/add%20document/cubit/add_document_cubit.dart';
import 'package:information_retrieval/features/add%20document/widgets/document_content_field.dart';
import 'package:information_retrieval/features/add%20document/widgets/add_document_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddDocumentScreen extends StatefulWidget {
  const AddDocumentScreen({super.key});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _addDocument() {
    final content = _contentController.text.trim();
    if (content.isNotEmpty) {
      context.read<AddDocumentCubit>().addDocument(content);
    } else {
      Fluttertoast.showToast(
        msg: "Please enter document content",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        fontSize: 16.0,
      );
    }
  }

  void _clearContent() {
    _contentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Document',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AddDocumentCubit, AddDocumentState>(
        listener: (context, state) {
          if (state is AddDocumentSuccess) {
            Navigator.pop(context, true); // Return true to indicate success
          } else if (state is AddDocumentError) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddDocumentLoading;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Content Label
                  Text(
                    'Document Content:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Document Content Field
                  DocumentContentField(
                    controller: _contentController,
                    enabled: !isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Add Button
                  AddDocumentButton(
                    isLoading: isLoading,
                    onPressed: _addDocument,
                  ),

                  const SizedBox(height: 16),

                  // Clear Button
                  TextButton(
                    onPressed: isLoading ? null : _clearContent,
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}