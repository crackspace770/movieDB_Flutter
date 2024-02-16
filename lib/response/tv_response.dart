import 'dart:convert';

import 'package:movie_db_flutter/model/tv.dart';

class TvResponse {
  int page;
  List<Tv> tv;
  int totalPages;
  int totalResults;

  TvResponse({
    required this.page,
    required this.tv,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvResponse.fromRawJson(String str) => TvResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
    page: json["page"],
    tv: List<Tv>.from(json["results"].map((x) => Tv.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(tv.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

