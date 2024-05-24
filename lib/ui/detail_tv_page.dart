
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import '../api/api_service.dart';
import '../api/endpoint.dart';
import '../provider/movie_provider.dart';
import '../provider/tv_detail_provider.dart';

class DetailTvPage extends StatelessWidget {

  static const routeName = '/detail_tv';
  final String tvId;

  const DetailTvPage({required this.tvId, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TvDetailProvider> (
      create: (_) =>
          TvDetailProvider(apiService: ApiService(Client()), tvId: tvId),
      child: Scaffold(
        body: Consumer<TvDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              var tv = state.result.tv;


              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Stack(
                        children: [
                          if (tv.posterPath != null)
                  Image.network(
                    "${Endpoints.imageUrl}${tv.posterPath ?? ''}",
                      ),
                          SafeArea(
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                margin: const EdgeInsets.only(left: 25),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: ()=>Navigator.pop(context), // Changed this line
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          tv.name,
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
                                DateFormat('yyyy-MM-dd').format(tv.firstAirDate),
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
                                tv.voteAverage.toString(),
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
                                tv.voteCount.toString() , // Convert voteCount to string
                                style: const TextStyle(fontSize: 12.0),     ),
                            ],
                          ),
                        ],
                      ),

                      const Divider(

                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          tv.overview ,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15)

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