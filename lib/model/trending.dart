import 'dart:convert';


class Trending {
  bool adult;
  String backdropPath;
  int id;
  String title;
  String originalTitle;
  String overview;
  String posterPath;
  MediaType mediaType;
  DateTime releaseDate;
  double voteAverage;
  String name;
  String originalName;
  DateTime firstAirDate;


  Trending({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.releaseDate,
    required this.voteAverage,
    required this.name,
    required this.originalName,
    required this.firstAirDate,

  });

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
    adult: json["adult"]??"",
    backdropPath: json["backdrop_path"]??"",
    id: json["id"]??"",
    title: json["title"]??"",
    originalTitle: json["original_title"]??"",
    overview: json["overview"]??"",
    posterPath: json["poster_path"]??"",
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    releaseDate: json["release_date"] != null ? DateTime.parse(json["release_date"]) : DateTime.now(),
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0, // Handle null value
    name: json["name"]??"",
    originalName: json["original_name"]??"",
    firstAirDate: json["first_air_date"] == null ? DateTime.parse(json["first_air_date"]):DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "release_date": releaseDate,
    "vote_average": voteAverage,
    "name": name,
    "original_name": originalName,
    "first_air_date": firstAirDate,

  };
}

enum MediaType {
  MOVIE,
  TV
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV
});



class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}