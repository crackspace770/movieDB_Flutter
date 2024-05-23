

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_db_flutter/model/trending.dart';
import 'package:movie_db_flutter/widget/platform_widget.dart';
import 'package:movie_db_flutter/widget/trending_card.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../provider/movie_provider.dart';
import '../provider/trending_provider.dart';

class TrendingHorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TrendingProvider>(
      create: (_) => TrendingProvider(apiService: ApiService(Client())),
      child: Consumer<TrendingProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.result.trendings.length,
              itemBuilder: (context, index) {
                final trending = provider.result.trendings[index];
                return TrendingCard(trending: trending);
              },
            );
          } else if (provider.state == ResultState.noData) {
            return Center(child: Text(provider.message));
          } else if (provider.state == ResultState.error) {
            return Center(child: Text(provider.message));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
