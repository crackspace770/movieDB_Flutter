import 'dart:convert';
import 'package:movie_db_flutter/model/search.dart';


class SearchResponse {
  final int page;
  final List<Search> results;
  final int totalPages;
  final int totalResults;

  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      page: json['page'] ?? 0,
      results: (json['results'] as List)
          .map((i) => Search.fromJson(i))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((result) => result.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

