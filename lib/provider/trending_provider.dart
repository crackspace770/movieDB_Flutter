
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../api/api_service.dart';
import '../response/trending_response.dart';
import 'movie_provider.dart';

class TrendingProvider extends ChangeNotifier {
  final ApiService apiService;

  TrendingProvider({required this.apiService}) {
    _fetchAllTrending();
  }

  late TrendingResponse _trendingResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  TrendingResponse get result => _trendingResult;
  ResultState get state => _state;

  Future<void> _fetchAllTrending() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final trending = await apiService.getTrendingList();
      if (trending.trendings.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        _trendingResult = trending;
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