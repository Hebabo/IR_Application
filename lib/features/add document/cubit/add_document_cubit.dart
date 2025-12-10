import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:information_retrieval/data/repo/api_service.dart';

part 'add_document_state.dart';

class AddDocumentCubit extends Cubit<AddDocumentState> {
  final ApiService _apiService;

  AddDocumentCubit({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(AddDocumentInitial());

  Future<void> addDocument(String content) async {
    if (content.trim().isEmpty) {
      emit(AddDocumentError(message: 'Content cannot be empty'));
      return;
    }

    emit(AddDocumentLoading());

    try {
      final success = await _apiService.addDocument(content);
      
      if (success) {
        emit(AddDocumentSuccess());
      } else {
        emit(AddDocumentError(message: 'Failed to add document'));
      }
    } catch (e) {
      emit(AddDocumentError(message: 'Error: ${e.toString()}'));
    }
  }

  void reset() {
    emit(AddDocumentInitial());
  }
}