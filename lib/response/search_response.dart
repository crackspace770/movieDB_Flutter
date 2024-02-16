import 'dart:convert';
import 'package:movie_db_flutter/model/search.dart';


class SearchResponse {
  int page;
  List<Search> film;
  int totalPages;
  int totalResults;

  SearchResponse({
    required this.page,
    required this.film,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponse.fromRawJson(String str) => SearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    page: json["page"],
    film: List<Search>.from(json["results"].map((x) => Search.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(film.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

