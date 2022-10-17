// ignore_for_file: constant_identifier_names
import 'package:tv/presentation/widgets/tv_series_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/tv/tv_search_bloc.dart';

class SearchTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/search_tv';
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  State<SearchTvPage> createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<TvSearchBloc>().add(TvOnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSearchBloc, TvSearchState>(
              builder: (_, tv) {
                if (tv is TvSearchLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (tv is TvSearchHasData) {
                  final List<dynamic> result = [...tv.result];
                  return Expanded(
                      child: (result.isNotEmpty)
                          ? ListView.builder(
                              key: const Key('search-listview'),
                              itemBuilder: (_, index) =>
                                  TvSeriesCard(result[index]),
                              itemCount: result.length,
                            )
                          : const Center(
                              child: Text('Cannot Found Tv Series :('),
                            ));
                } else {
                  return const SizedBox(key: Key('search-error'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
