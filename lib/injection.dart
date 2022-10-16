import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/utils/ssl_pinning/http_ssl_pinning.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/presentation/bloc/movie_details_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:tv/data/datasources/tv_series_local_data_source.dart';
import 'package:tv/data/datasources/tv_series_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:tv/data/repositories/tv_series_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:tv/domain/usecases/get_airing_today_tv_series.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:tv/domain/usecases/get_popular_tv_series.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv/domain/usecases/get_tv_series_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_recomendations.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_series.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_series.dart';
import 'package:search/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:search/search.dart';
import 'package:tv/presentation/bloc/airing_today_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_details_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {
  //Movie bloc
  locator.registerFactory(
    () => MoviesSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailsBloc(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator()),
  );

  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
    ),
  );

  // Tv Bloc
  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => AiringTodayTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailsBloc(
        getTvDetail: locator(),
        getTvRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator()),
  );

  locator.registerFactory(
    () => TvWatchlistBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetAiringTodayTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
