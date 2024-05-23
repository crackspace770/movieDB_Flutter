import 'dart:convert';

import '../model/trending.dart';

class TrendingResponse {
  final int page;
  final List<Trending> trendings;
  final int totalPages;
  final int totalResults;

  TrendingResponse({
    required this.page,
    required this.trendings,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingResponse.fromJson(Map<String, dynamic> json) {
    return TrendingResponse(
      page: json['page'] ?? 0,
      trendings: (json['results'] as List)
          .map((i) => Trending.fromJson(i))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': trendings.map((trending) => trending.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

