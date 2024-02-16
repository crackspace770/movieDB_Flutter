import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_db_flutter/widget/platform_widget.dart';
import 'package:provider/provider.dart';

import '../model/movies.dart';
import '../provider/movie_provider.dart';
import '../widget/card_movie.dart';

class MovieHorizontalList extends StatelessWidget{
  const MovieHorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer<MovieProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return _buildList(state.result.movies);
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

  Widget _buildList(List<Movie> movies) {
    return PlatformWidget(
      androidBuilder: (context) => _buildAndroid(context, movies),
      iosBuilder: (context) => _buildIos(context, movies),
    );
  }

  Widget _buildAndroid(BuildContext context, List<Movie> movies) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var movie in movies)
            MovieCard(movie: movie),
        ],
      ),
    );
  }

  Widget _buildIos(BuildContext context, List<Movie> movies) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var movie in movies)
            MovieCard(movie: movie),
        ],
      ),
    );
  }



}