

import 'package:flutter/material.dart';
import 'package:movie_db_flutter/model/trending.dart';
import 'package:movie_db_flutter/widget/platform_widget.dart';
import 'package:movie_db_flutter/widget/trending_card.dart';
import 'package:provider/provider.dart';

import '../provider/movie_provider.dart';
import '../provider/trending_provider.dart';

class TrendingHorizontalList extends StatelessWidget{
  const TrendingHorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer<TrendingProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return _buildList(state.result.trendings);
          } else if (state.state == ResultState.noData || state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildList(List<Trending> movies) {
    return PlatformWidget(
      androidBuilder: (context) => _buildAndroid(context, movies),
      iosBuilder: (context) => _buildIos(context, movies),
    );
  }

  Widget _buildAndroid(BuildContext context, List<Trending> trending) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var trending in trending)
            TrendingCard(trending: trending),
        ],
      ),
    );
  }

  Widget _buildIos(BuildContext context, List<Trending> trending) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var trending in trending)
            TrendingCard(trending: trending),
        ],
      ),
    );
  }



}