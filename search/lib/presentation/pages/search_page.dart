// ignore_for_file: constant_identifier_names

import 'package:movie/domain/entities/movie.dart';
import 'package:tv/presentation/widgets/tv_series_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie/movie_search_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

import '../bloc/tv/tv_search_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context
                    .read<MoviesSearchBloc>()
                    .add(MoviesOnQueryChanged(query));
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
            BlocBuilder<MoviesSearchBloc, MoviesSearchState>(
              builder: (_, movie) => BlocBuilder<TvSearchBloc, TvSearchState>(
                builder: (_, tv) {
                  if (movie is MoviesSearchLoading && tv is TvSearchLoading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (tv is TvSearchHasData &&
                      movie is MoviesSearchHasData) {
                    final List<dynamic> result = [
                      ...movie.result,
                      ...tv.result
                    ];
                    return Expanded(
                        child: (result.isNotEmpty)
                            ? ListView.builder(
                                key: const Key('search-listview'),
                                itemBuilder: (_, index) =>
                                    (result[index] is Movie)
                                        ? MovieCard(result[index])
                                        : TvSeriesCard(result[index]),
                                itemCount: result.length,
                              )
                            : const Center(
                                child: Text(
                                    'Cannot Found Movies and Tv Series :('),
                              ));
                  } else {
                    return const SizedBox(key: Key('search-error'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
