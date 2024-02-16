
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:movie_db_flutter/model/movies.dart';
import 'package:movie_db_flutter/response/movie_response.dart';


import '../api/api_service.dart';

enum ResultState { loading, noData, hasData, error, initialLoad }

class MovieProvider extends ChangeNotifier {
  final ApiService apiService;

  MovieProvider({required this.apiService}) {
    _fetchAllMovie();
  }

  late MovieResponse _movieResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  MovieResponse get result => _movieResult;
  ResultState get state => _state;

  Future<void> _fetchAllMovie() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final movie = await apiService.getMovieList();
      if (movie.movies.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        _movieResult = movie;
      }
    } on SocketException {
      _state = ResultState.error;
      _message = 'Connection Error';
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to load data: $e';
    } finally {
      notifyListeners();
    }
  }
}