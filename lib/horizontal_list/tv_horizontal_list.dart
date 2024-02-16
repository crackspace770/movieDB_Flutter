
import 'package:flutter/material.dart';
import 'package:movie_db_flutter/widget/platform_widget.dart';
import 'package:provider/provider.dart';

import '../model/tv.dart';
import '../provider/movie_provider.dart';
import '../provider/tv_provider.dart';
import '../widget/card_tv.dart';

class TvHorizontalList extends StatelessWidget{
  const TvHorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer<TvProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return _buildList(state.result.tv);
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

  Widget _buildList(List<Tv> movies) {
    return PlatformWidget(
      androidBuilder: (context) => _buildAndroid(context, movies),
      iosBuilder: (context) => _buildIos(context, movies),
    );
  }

  Widget _buildAndroid(BuildContext context, List<Tv> tv) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var tv in tv)
            TvCard(tv: tv),
        ],
      ),
    );
  }

  Widget _buildIos(BuildContext context, List<Tv> tv) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var tv in tv)
            TvCard(tv: tv),
        ],
      ),
    );
  }



}