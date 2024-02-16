
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_db_flutter/ui/search_page.dart';
import 'package:movie_db_flutter/ui/setting_page.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../common/style.dart';
import '../provider/movie_provider.dart';
import '../provider/search_provider.dart';
import '../widget/platform_widget.dart';
import 'list_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Home';
  static const String _searchText = 'Search';
  static const String _settingText='Setting';

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<MovieProvider>(
      create: (_) => MovieProvider(apiService: ApiService(Client())),
      child: const ListPage(),
    ),
    ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(apiService: ApiService(Client())),
      child: SearchPage(),
    ),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.square_grid_2x2 : Icons.menu, color: Colors.blue),
      label: _headlineText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.search: Icons.search, color: Colors.blue),
      label: _searchText,
    ),

    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings, color: Colors.blue),
      label: _settingText,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }


  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }


 // @override
 // void initState() {
 //   super.initState();
 //   _notificationHelper.configureSelectNotificationSubject(RestaurantDetailPage.routeName);
//  }

//  @override
 // void dispose() {
 //   selectNotificationSubject.close();
 //   super.dispose();
 /// }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

}