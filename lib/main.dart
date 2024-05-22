import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart';
import 'package:movie_db_flutter/provider/movie_provider.dart';
import 'package:movie_db_flutter/provider/preference_provider.dart';
import 'package:movie_db_flutter/provider/search_provider.dart';
import 'package:movie_db_flutter/provider/trending_provider.dart';
import 'package:movie_db_flutter/provider/tv_provider.dart';
import 'package:movie_db_flutter/ui/detail_movie_page.dart';
import 'package:movie_db_flutter/ui/detail_tv_page.dart';
import 'package:movie_db_flutter/ui/home_page.dart';
import 'package:movie_db_flutter/ui/list_page.dart';
import 'package:movie_db_flutter/ui/search_page.dart';
import 'package:movie_db_flutter/utils/preference_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieProvider>(
          create: (_) => MovieProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<TvProvider>(
          create: (_) => TvProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<TrendingProvider>(
          create: (_) => TrendingProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(
            apiService: ApiService(Client()),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return GetMaterialApp(
            title: 'MovieDB',
            debugShowCheckedModeBanner: false,
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              SearchPage.routeName:  (context) => SearchPage(),
              DetailMoviePage.routeName: (context) => DetailMoviePage(
                movieId:
                ModalRoute.of(context)?.settings.arguments as String,
              ),
              DetailTvPage.routeName: (context) =>DetailTvPage(
                  tvId: ModalRoute.of(context)?.settings.arguments as String
              ),
            //  FavoritePage.routeName: (context) => const FavoritePage(),
            },
          );
        },
      ),
    );
  }
}
