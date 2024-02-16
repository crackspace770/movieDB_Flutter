
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../api/api_service.dart';
import '../response/search_response.dart';
import 'movie_provider.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});

  late SearchResponse _searchResult;
  ResultState _state = ResultState.initialLoad;
  String _message = '';

  String get message => _message;
  SearchResponse get result => _searchResult;
  ResultState get state => _state;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _state = ResultState.error;
      _message = 'Please fill in the search field!';
      notifyListeners();
      return;
    }

    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.searchRestaurant(query);

      if (response.film.isEmpty) {
        _state = ResultState.noData;
        _message = 'No results found';
      } else {
        _state = ResultState.hasData;
        _searchResult = response;
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