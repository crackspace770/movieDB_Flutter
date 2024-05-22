
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:movie_db_flutter/provider/tv_provider.dart';
import '../api/api_service.dart';
import '../response/tv_detail_response.dart';
import 'movie_provider.dart';


class TvDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? tvId;

  TvDetailProvider(
      {required this.apiService, required this.tvId}) {
    fetchDetailTv(tvId!);
  }

  late TvDetailResponse _detailTv;
  String _message = '';
  late ResultState _state;

  String get message => _message;
  TvDetailResponse get result => _detailTv;
  ResultState get state => _state;

  Future<dynamic> fetchDetailTv(String tvId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final tv = await apiService.getDetailTv(tvId);
      if (tv == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailTv = tv;
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