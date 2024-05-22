import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_db_flutter/ui/detail_movie_page.dart';

import '../api/endpoint.dart';
import '../model/movies.dart';


class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailMoviePage.routeName,
                    arguments: movie.id.toString());
              },
              child: Hero(
                tag: movie.posterPath,
                child: Image.network(
                  "${Endpoints.imageUrl}${movie.posterPath}",

                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error, _) => const Center(
                    child: Icon(
                      Icons.error_outline_sharp,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          SizedBox(
            width: 100,
            child: Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 2.0),
          Row(
            children: [
              const Icon(
                Icons.date_range_outlined,
                color: Colors.blueAccent,
                size: 16.0,
              ),
              SizedBox(width: 2.0),
              Text(
                DateFormat('yyyy-MM-dd').format(movie.releaseDate),
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.blueAccent,
                size: 16.0,
              ),
              SizedBox(width: 2.0),
              Text(
                movie.voteAverage.toString(),
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}