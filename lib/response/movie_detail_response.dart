import 'dart:convert';

import 'package:movie_db_flutter/model/movie_detail.dart';

class MovieDetailResponse {
  bool error;
  String message;
  MovieDetail movies;

  MovieDetailResponse ({
    required this.error,
    required this.message,
    required this.movies,
  });

  factory MovieDetailResponse .fromRawJson(String str) => MovieDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieDetailResponse .fromJson(Map<String, dynamic> json) => MovieDetailResponse (
    error: json["error"] ?? false,
    message: json["message"] ?? "",
    movies: MovieDetail.fromJson(json["movies"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "movies": movies.toJson(),
  };
}