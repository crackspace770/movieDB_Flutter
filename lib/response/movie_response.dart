
import 'dart:convert';

import '../model/movies.dart';

class MovieResponse {
  int page;
  List<Movie> movies;
  int totalPages;
  int totalResults;

  MovieResponse({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromRawJson(String str) => MovieResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
    page: json["page"],
    movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(movies.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

