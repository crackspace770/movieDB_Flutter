
import 'dart:convert';

class Search {
  bool adult;
  int id;
  String name;
  OriginalLanguage originalLanguage;
  String overview;
  String? posterPath;
  MediaType mediaType;
  List<int> genreIds;
  double popularity;
  DateTime firstAirDate;
  double voteAverage;
  int voteCount;
  List<String>? originCountry;
  String title; // Make it nullable
  String originalTitle;
  String releaseDate;
  bool? video;

  Search({
    required this.adult,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.video,
  });

  factory Search.fromRawJson(String str) => Search.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    adult: json["adult"],
    id: json["id"],
    name: json["name"],
    originalLanguage: originalLanguageValues.map[json["original_language"]]!,
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
    title: json["title"],
    originalTitle: json["original_title"],
    releaseDate: json["release_date"],
    video: json["video"],
    firstAirDate: DateTime.parse(json["first_air_date"]),
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "id": id,
    "name": name,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
    "title": title,
    "original_title": originalTitle,
    "release_date": releaseDate,
    "video": video,
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

enum OriginalLanguage {
  EN
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN
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
