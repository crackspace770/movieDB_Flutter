import 'dart:io';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../response/tv_response.dart';
import 'movie_provider.dart';


class TvProvider extends ChangeNotifier {
  final ApiService apiService;

  TvProvider({required this.apiService}) {
    _fetchAllTv();
  }

  late TvResponse _tvResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  TvResponse get result => _tvResult;
  ResultState get state => _state;

  Future<void> _fetchAllTv() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final tv = await apiService.getTvList();
      if (tv.tv.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        _tvResult = tv;
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