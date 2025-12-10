part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<SearchResult> results;
  final SearchMethod method;
  final List<String> processingSteps;
  final int totalResults;

  SearchSuccess({
    required this.results,
    required this.method,
    required this.processingSteps,
    required this.totalResults,
  });

  @override
  List<Object?> get props => [results, method, processingSteps, totalResults];
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});

  @override
  List<Object?> get props => [message];
}