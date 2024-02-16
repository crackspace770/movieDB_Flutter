import 'dart:convert';


class Trending {
  bool adult;
  String backdropPath;
  int id;
  String? title;
  String? originalTitle;
  String overview;
  String posterPath;
  MediaType mediaType;
  DateTime? releaseDate;
  bool? video;
  double voteAverage;
  String? name;
  String? originalName;
  DateTime? firstAirDate;
  List<String>? originCountry;

  Trending({
    required this.adult,
    required this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    this.releaseDate,
    this.video,
    required this.voteAverage,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    video: json["video"],
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0, // Handle null value
    name: json["name"],
    originalName: json["original_name"],
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
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
    "release_date": releaseDate?.toIso8601String(),
    "video": video,
    "vote_average": voteAverage,
    "name": name,
    "original_name": originalName,
    "first_air_date": firstAirDate?.toIso8601String(),
    "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
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