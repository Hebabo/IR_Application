import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:information_retrieval/core/widgets/loading_animation.dart';
import 'package:information_retrieval/data/models/search_model.dart';
import 'package:information_retrieval/features/search/cubit/search_cubit.dart';
import 'package:information_retrieval/features/search/widgets/search_header.dart';
import 'package:information_retrieval/features/search/widgets/search_results_list.dart';
import 'package:information_retrieval/features/search/widgets/search_empty_state.dart';
import 'package:information_retrieval/features/search/widgets/search_error_state.dart';
import 'package:information_retrieval/core/routes/app_routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  void _searchWithTerm(String term) {
    _searchController.text = term;
    setState(() {
      _selectedMethod = SearchMethod.invertedIndex;
    });
    context.read<SearchCubit>().search(term, SearchMethod.invertedIndex);
  }

  void _onMethodChanged(SearchMethod method) {
    setState(() {
      _selectedMethod = method;
    });
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
    
    if (result == true && mounted) {
      Fluttertoast.showToast(
        msg: "Document added to corpus",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        fontSize: 16.sp,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Search',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black87,
              size: 28.sp,
            ),
            onPressed: _navigateToAddDocument,
            tooltip: 'Add Document',
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
  child: GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Column(
      children: [
        // Search Header (fixed height)
        SearchHeader(
          searchController: _searchController,
          selectedMethod: _selectedMethod,
          onSearch: _performSearch,
          onClear: _onClearSearch,
          onMethodChanged: _onMethodChanged,
        ),

        // Results (scrollable)
        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchInitial) {
                return const SearchEmptyState();
              } else if (state is SearchLoading) {
                return const Center(child: LoadingAnimation());
              } else if (state is SearchSuccess) {
                return SearchResultsList(
                  results: state.results,
                  processingSteps: state.processingSteps,
                  totalResults: state.totalResults,
                  suggestedTerms: state.suggestedTerms,
                  query: state.query,
                  onSuggestedTermTap: _searchWithTerm,
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
  ),
),

    );
  }
}