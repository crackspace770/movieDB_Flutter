
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_db_flutter/model/trending.dart';

import '../api/endpoint.dart';
import '../ui/detail_trending_page.dart';

class TrendingCard extends StatelessWidget {
  final Trending trending;

  const TrendingCard({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailTrendingPage.routeName,
                    arguments: trending.id.toString());
              },
              child: trending.posterPath != null
                  ? Hero(
                tag: trending.posterPath!,
                child: Image.network(
                  "${Endpoints.imageUrl}${trending.posterPath}",
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error, _) => const Center(
                    child: Icon(
                      Icons.error_outline_sharp,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
                  : Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 100,
            child: Text(
              trending.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 2.0),
          Row(
            children: [
              const Icon(
                Icons.date_range_outlined,
                color: Colors.blueAccent,
                size: 16.0,
              ),
              const SizedBox(width: 2.0),
              Text(
                DateFormat('yyyy-MM-dd').format(trending.releaseDate!),
                style: const TextStyle(fontSize: 12.0),
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
              const SizedBox(width: 2.0),
              Text(
                trending.voteAverage.toString(),
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}