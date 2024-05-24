
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_db_flutter/model/search.dart';

import '../api/endpoint.dart';
import '../ui/detail_movie_page.dart';
import '../ui/detail_tv_page.dart';

class MultiCard extends StatelessWidget {
  final Search searchResult;

  const MultiCard({Key? key, required this.searchResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  () {
      if (searchResult.mediaType == MediaType.MOVIE) {
        Navigator.pushNamed(
          context,
          DetailMoviePage.routeName,
          arguments: searchResult.id.toString(),
        );
      } else if (searchResult.mediaType == MediaType.TV) {
        Navigator.pushNamed(
          context,
          DetailTvPage.routeName,
          arguments: searchResult.id.toString(),
        );
      }
    },
      child: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey)
          ),
         child: Row(
           children: [
              searchResult.posterPath != null
                 ? Hero(
               tag: searchResult.posterPath ?? '',
               child: Image.network(
                 "${Endpoints.imageUrl}${searchResult.posterPath ?? ''}",
                 fit: BoxFit.cover,
                 errorBuilder: (ctx, error, _) => const Center(
                   child: Icon(
                     Icons.error_outline_sharp,
                     color: Colors.red,
                   ),
                 ),
               ),
             )
                 : Container( // Placeholder container
               width: 100, // Set the width and height of the placeholder
               height: 100,
               color: Colors.grey, // Set the color of the placeholder
               child: const Icon(
                 Icons.image_not_supported,
                 color: Colors.white,
               ),
             ),
             const SizedBox(width: 15),
             Center(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   SizedBox(
                     width: 200,
                     child: Text(
                         searchResult.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                     ),
                   ),
                   Row(
                     children: [
                       Text(searchResult.voteAverage.toString() ??''),
                       const Icon(Icons.star),
                     ],
                   ),
                   Text(DateFormat('yyyy-MM-dd').format(searchResult.releaseDate)),
                 ],
               ),
             )

           ],
         ),
        ),
      ),
    );
  }
}