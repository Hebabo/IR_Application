import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/features/search/cubit/search_cubit.dart';
import 'package:information_retrieval/features/search/widgets/search_header.dart';
import 'package:information_retrieval/features/search/widgets/search_results_list.dart';
import 'package:information_retrieval/features/search/widgets/search_empty_state.dart';
import 'package:information_retrieval/features/search/widgets/search_error_state.dart';
import 'package:information_retrieval/core/routes/app_routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  SearchMethod _selectedMethod = SearchMethod.invertedIndex;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<SearchCubit>().search(query, _selectedMethod);
    }
  }

  void _onMethodChanged(SearchMethod method) {
    setState(() {
      _selectedMethod = method;
    });
    // Re-search if there's already a query
    if (_searchController.text.trim().isNotEmpty) {
      _performSearch();
    }
  }

  void _onClearSearch() {
    setState(() {
      _searchController.clear();
      context.read<SearchCubit>().reset();
    });
  }

  Future<void> _navigateToAddDocument() async {
    final result = await Navigator.pushNamed(context, AppRoutes.addDocument);
    
    // If document was added successfully, show a message
    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document added to corpus'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.black87,
              size: 28,
            ),
            onPressed: _navigateToAddDocument,
            tooltip: 'Add Document',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search Header Section
          SearchHeader(
            searchController: _searchController,
            selectedMethod: _selectedMethod,
            onSearch: _performSearch,
            onClear: _onClearSearch,
            onMethodChanged: _onMethodChanged,
          ),

          // Results Section
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const SearchEmptyState();
                } else if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black87,
                    ),
                  );
                } else if (state is SearchSuccess) {
                  return SearchResultsList(
                    results: state.results,
                    processingSteps: state.processingSteps,
                    totalResults: state.totalResults,
                  );
                } else if (state is SearchError) {
                  return SearchErrorState(
                    message: state.message,
                    onRetry: _performSearch,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}