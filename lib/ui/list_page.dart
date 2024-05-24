
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../horizontal_list/movie_horizontal_list.dart';
import '../horizontal_list/trending_horizontal_list.dart';
import '../horizontal_list/tv_horizontal_list.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieDB'),
        centerTitle: true,
      ),
      body:  const Column(
        children: [
       //   const SizedBox(height: 16),
      //    const Text(
      //      'Trending Now',
     //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
     //     ),
     //     Expanded(
     //         child: TrendingHorizontalList()
     //     ),
          SizedBox(height: 16), // Add spacing between lists if needed
          Text(
            'Movies',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: MovieHorizontalList(),
          ),
          SizedBox(height: 16), // Add spacing between lists if needed
          Text(
            'TV Shows',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: TvHorizontalList(),
          ),

        ],
      ),
    );
  }
}