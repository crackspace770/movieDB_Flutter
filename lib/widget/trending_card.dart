
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_db_flutter/model/trending.dart';

import '../api/endpoint.dart';

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
                // Handle tap
              },
              child: trending.posterPath != null
                  ? Hero(
                tag: trending.posterPath!,
                child: Image.network(
                  "${Endpoints.imageUrl}${trending.posterPath!}",
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
                // Placeholder container
                width: 100, // Set the width and height of the placeholder
                height: 100,
                color: Colors.grey, // Set the color of the placeholder
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          SizedBox(
            width: 100, // Adjust this width as per your design
            child: Text(
              trending.name ?? '', // Use empty string as default if name is null
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                trending.releaseDate != null
                    ? DateFormat('yyyy-MM-dd').format(trending.releaseDate!)
                    : '', // Use empty string as default if releaseDate is null
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
                trending.voteAverage != null
                    ? trending.voteAverage.toString()
                    : '', // Use empty string as default if voteAverage is null
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}