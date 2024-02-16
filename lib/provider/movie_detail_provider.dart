
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../api/api_service.dart';
import '../response/movie_detail_response.dart';
import 'movie_provider.dart';

class MovieDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? movieId;

  MovieDetailProvider(
      {required this.apiService, required this.movieId}) {
    fetchDetailRestaurant(movieId!);
  }

  late MovieDetailResponse _detailMovie;
  String _message = '';
  late ResultState _state;

  String get message => _message;
  MovieDetailResponse get result => _detailMovie;
  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant(String movieId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final movies = await apiService.getDetailMovie(movieId);
      if (movies == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailMovie = movies;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Connection Error';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}