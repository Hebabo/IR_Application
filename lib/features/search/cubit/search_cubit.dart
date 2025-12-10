import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/data/repo/api_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ApiService _apiService;

  SearchCubit({ApiService? apiService}) 
      : _apiService = apiService ?? ApiService(),
        super(SearchInitial());

  Future<void> search(String query, SearchMethod method) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final searchResponse = await _apiService.search(query, method);
      
      // Convert DocumentResults to SearchResults for display
      final results = searchResponse.documents
          .asMap()
          .entries
          .map((entry) => SearchResult.fromDocument(
                entry.value,
                entry.key,
                searchResponse.documents.length,
              ))
          .toList();
      
      emit(SearchSuccess(
        results: results,
        method: method,
        processingSteps: searchResponse.processingSteps,
        totalResults: searchResponse.totalResults,
        suggestedTerms: searchResponse.suggestedTerms,
        query: query,
      ));
    } catch (e) {
      emit(SearchError(message: 'Failed to perform search: ${e.toString()}'));
    }
  }

  void reset() {
    emit(SearchInitial());
  }
}