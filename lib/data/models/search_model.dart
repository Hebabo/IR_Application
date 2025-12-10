// Enum for search methods
enum SearchMethod {
  invertedIndex,
  positionalIndex,
  soundex,
}

// Model for document in search results
class DocumentResult {
  final int docId;
  final String content;

  DocumentResult({
    required this.docId,
    required this.content,
  });

  factory DocumentResult.fromJson(Map<String, dynamic> json) {
    return DocumentResult(
      docId: json['docId'] ?? 0,
      content: json['content'] ?? '',
    );
  }
}

// Model for complete search response
class SearchResponse {
  final List<DocumentResult> documents;
  final List<String> processingSteps;
  final int totalResults;
  final List<String>? suggestedTerms; // For Soundex

  SearchResponse({
    required this.documents,
    required this.processingSteps,
    required this.totalResults,
    this.suggestedTerms,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      documents: (json['documents'] as List<dynamic>?)
              ?.map((doc) => DocumentResult.fromJson(doc))
              .toList() ??
          [],
      processingSteps: (json['processingSteps'] as List<dynamic>?)
              ?.map((step) => step.toString())
              .toList() ??
          [],
      totalResults: json['totalResults'] ?? 0,
      suggestedTerms: (json['suggestedTerms'] as List<dynamic>?)
              ?.map((term) => term.toString())
              .toList(),
    );
  }
}

// Model for search results (for backward compatibility with UI)
class SearchResult {
  final String title;
  final String snippet;
  final double relevance;

  SearchResult({
    required this.title,
    required this.snippet,
    required this.relevance,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'] ?? '',
      snippet: json['snippet'] ?? '',
      relevance: (json['relevance'] ?? 0.0).toDouble(),
    );
  }

  // Convert DocumentResult to SearchResult for display
  factory SearchResult.fromDocument(DocumentResult doc, int index, int total) {
    return SearchResult(
      title: 'Document ${doc.docId}',
      snippet: doc.content,
      relevance: 1.0 - (index / total), // Calculate relevance based on position
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'snippet': snippet,
      'relevance': relevance,
    };
  }
}