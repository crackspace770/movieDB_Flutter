
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../common/style.dart';
import '../utils/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();

  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;


  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }



  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }


}