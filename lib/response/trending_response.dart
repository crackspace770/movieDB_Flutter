import 'dart:convert';

import '../model/trending.dart';

class TrendingResponse {
  int page;
  List<Trending> trendings;
  int totalPages;
  int totalResults;

  TrendingResponse({
    required this.page,
    required this.trendings,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingResponse.fromRawJson(String str) => TrendingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrendingResponse.fromJson(Map<String, dynamic> json) => TrendingResponse(
    page: json["page"],
    trendings: List<Trending>.from(json["results"].map((x) => TrendingResponse.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(trendings.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}


