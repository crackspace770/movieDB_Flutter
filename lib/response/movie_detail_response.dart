import 'dart:convert';

import 'package:movie_db_flutter/model/movie_detail.dart';

class MovieDetailResponse {
  bool error;
  String message;
  MovieDetail movie;

  MovieDetailResponse({
    required this.error,
    required this.message,
    required this.movie,
  });

  factory MovieDetailResponse.fromRawJson(String str) => MovieDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailResponse(
      error: json["error"] ?? false, // Handle possible null value
      message: json["message"] ?? "",
      movie: MovieDetail.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "movie": movie.toJson(),
  };
}
