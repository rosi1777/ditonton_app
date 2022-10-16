import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<MovieWatchlistBloc>(context)
      ..add(FetchMovieWatchlist()));
    Future.microtask(() =>
        BlocProvider.of<TvWatchlistBloc>(context)..add(FetchTvWatchlist()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context).add(FetchMovieWatchlist());
    BlocProvider.of<TvWatchlistBloc>(context).add(FetchTvWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Movie',
              ),
              Tab(
                text: 'Tv',
              ),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              children: <Widget>[
                Column(
                  children: [
                    Expanded(child: movie()),
                  ],
                ),
                Column(
                  children: [
                    Expanded(child: tv()),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget movie() {
    return BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
      builder: (context, state) {
        if (state is MovieWatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieWatchlistHasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = state.result[index];
              return MovieCard(movie);
            },
            itemCount: state.result.length,
          );
        } else if (state is MovieWatchlistEmpty) {
          return const Center(
            child: Text("You Don't Have Watchlist Movies"),
          );
        } else {
          return Center(
            child: Text((state as MovieWatchlistError).message),
          );
        }
      },
    );
  }

  Widget tv() {
    return BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
      builder: (context, state) {
        if (state is TvWatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvWatchlistHasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final tv = state.result[index];
              return TvSeriesCard(tv);
            },
            itemCount: state.result.length,
          );
        } else if (state is TvWatchlistEmpty) {
          return const Center(
            child: Text("You Don't Have Watchlist Tv"),
          );
        } else {
          return Center(
            child: Text((state as TvWatchlistError).message),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
