
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movie_provider.dart';
import '../provider/search_provider.dart';
import '../widget/multi_card.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  SearchPage({Key? key}) : super(key: key);

  static const routeName = '/search_page';
  static const String searchTitle = 'Search';

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Color(0xFF0E0E0E),
                      hintText: "What movie you're looking for?",
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    onChanged: (keyword) {
                      searchProvider.search(keyword);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Consumer<SearchProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.hasData) {
                    if (state.result.results.isEmpty) {
                      return const Text("Data Not Found");
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.result.results.length,
                          itemBuilder: (context, index) {
                            var search = state.result.results[index];
                            return MultiCard(searchResult: search);
                          }
                      );
                    }
                  } else if (state.state == ResultState.noData) {
                    return const Text("Data Not Found");
                  } else if (state.state == ResultState.error) {
                    return Text(state.message);
                  } else if (state.state == ResultState.initialLoad) {
                    return const Text(
                      "Search any movie you want",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return const SizedBox(); // Return an empty SizedBox if state is not handled
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}