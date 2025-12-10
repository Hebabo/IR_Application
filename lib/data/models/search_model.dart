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

  SearchResponse({
    required this.documents,
    required this.processingSteps,
    required this.totalResults,
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
    );
  }
}

// Model for search results (for backward compatibility with UI)
class SearchResult {
  final String title;
  final String snippet;

  SearchResult({
    required this.title,
    required this.snippet,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'] ?? '',
      snippet: json['snippet'] ?? '',
    );
  }

  // Convert DocumentResult to SearchResult for display
  factory SearchResult.fromDocument(DocumentResult doc, int index, int total) {
    return SearchResult(
      title: 'Document ${doc.docId}',
      snippet: doc.content,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'snippet': snippet,
    };
  }
}