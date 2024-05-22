import 'dart:convert';

import '../model/tv_detail.dart';

class TvDetailResponse {
  bool error;
  String message;
  TvDetail tv;

  TvDetailResponse({
    required this.error,
    required this.message,
    required this.tv,
  });

  factory TvDetailResponse.fromRawJson(String str) => TvDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) => TvDetailResponse(
    error: json["error"] ?? false,
    message: json["message"] ?? "",
    tv: TvDetail.fromJson(json),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "tv": tv.toJson(),
  };
}