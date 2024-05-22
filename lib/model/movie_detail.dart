import 'dart:convert';

class MovieDetail {
  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String backdropPath;
  int id;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"] ?? "",
    id: json["id"] ?? 0,
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    popularity: json["popularity"]?.toDouble() ?? 0.0,
    posterPath: json["poster_path"] ?? "",
    releaseDate: json["release_date"] != null ? DateTime.parse(json["release_date"]) : DateTime.now(),
    title: json["title"] ?? "",
    voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate.toIso8601String(),
    "title": title,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

