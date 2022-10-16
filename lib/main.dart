import 'package:about/about_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/ssl_pinning/http_ssl_pinning.dart';
import 'package:core/utils/utils.dart';
import 'package:core/styles/text_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie/presentation/bloc/movie_details_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:tv/presentation/bloc/airing_today_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_details_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_series_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_series_page.dart';
import 'package:tv/presentation/pages/tv_series_detail_page.dart';
import 'package:tv/presentation/pages/tv_series_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<MoviesSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailsBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<AiringTodayTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvDetailsBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => const SearchPage(),
              );
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case TvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const TvSeriesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedTvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
