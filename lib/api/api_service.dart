import 'dart:convert';

import 'package:movie_db_flutter/model/movies.dart';
import 'package:movie_db_flutter/response/trending_response.dart';

import '../response/movie_detail_response.dart';
import '../response/movie_response.dart';
import '../response/search_response.dart';
import '../response/tv_detail_response.dart';
import '../response/tv_response.dart';
import 'endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class ApiService {
  final Client client;
  ApiService(this.client);


  Future<MovieResponse> getMovieList() async {
    try {
      final response = await client.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load movie list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching movie list: $e');
      throw Exception('Failed to load movie list: $e');
    }
  }

  Future<TvResponse> getTvList() async {
    final response = await client.get(Uri.parse("https://api.themoviedb.org/3/tv/popular?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load menu');
    }
  }

  Future<TrendingResponse> getTrendingList() async {
    final response = await client.get(Uri.parse("https://api.themoviedb.org/3/tv/popular?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
    if (response.statusCode == 200) {
      return TrendingResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load menu');
    }
  }

  Future<SearchResponse> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse("https://api.themoviedb.org/3/search/multi?query=${query}&include_adult=true&api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load menu');
    }
  }

  Future<MovieDetailResponse> getDetailMovie(String id) async {
    try {
      final response = await client.get(Uri.parse("https://api.themoviedb.org/3/movie/${id}?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
      if (response.statusCode == 200) {
        return MovieDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load top headlines');
      }
    } on Error catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong ');
    }
  }

  Future<TvDetailResponse> getDetailTv(String id) async {
    try {
      final response = await client.get(Uri.parse("https://api.themoviedb.org/3/tv/${id}?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
      if (response.statusCode == 200) {
        return TvDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load top headlines');
      }
    } on Error catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong ');
    }
  }

}
