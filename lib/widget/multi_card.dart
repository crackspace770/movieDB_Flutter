
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_flutter/model/search.dart';

import '../api/endpoint.dart';

class MultiCard extends StatelessWidget {
  final Search searchResult;

  const MultiCard({Key? key, required this.searchResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: searchResult.posterPath ?? '', // Provide a fallback tag or handle null case
        child: Image.network(
          "${Endpoints.imageUrl}${searchResult.posterPath ?? ''}", // Provide a fallback URL or handle null case
          width: 100,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
        ),
      ),
      title: Text(searchResult.name ?? ''), // Provide a fallback text or handle null case

      onTap: () {
        // Handle onTap
      },
    );
  }
}