
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:movie_db_flutter/provider/movie_detail_provider.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../api/endpoint.dart';
import '../provider/movie_provider.dart';

class DetailMoviePage extends StatelessWidget {
  static const routeName = '/detail_movie';
  final String movieId;

  const DetailMoviePage({required this.movieId, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieDetailProvider>(
      create: (_) => MovieDetailProvider(apiService: ApiService(Client()), movieId: movieId),
      child: Scaffold(
        body: Consumer<MovieDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              var movie = state.result.movie;

              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Stack(
                        children: [
                          if (movie.posterPath != null)
                            Image.network(
                              "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                            ),
                          const SafeArea(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.blue,
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd').format(movie.releaseDate),
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.blue,
                              ),
                              Text(
                                movie.voteAverage.toString(),
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.how_to_vote,
                                color: Colors.blue,
                              ),
                              Text(
                                movie.voteCount.toString(),
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          movie.overview,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }
}