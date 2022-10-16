import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_details_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';

class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMoviesEvent {}

class FakeNowPlayingMoviesState extends Fake implements NowPlayingMoviesState {}

class FakeNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

/// fake popular movies bloc
class FakePopularMoviesEvent extends Fake implements PopularMoviesEvent {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

/// fake top rated movies bloc
class FakeTopRatedMoviesEvent extends Fake implements TopRatedMoviesEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

/// fake movie details bloc
class FakeMovieDetailsEvent extends Fake implements MovieDetailsEvent {}

class FakeMovieDetailsState extends Fake implements MovieDetailsState {}

class FakeMovieDetailsBloc extends MockBloc<MovieDetailsEvent, MovieDetailsState>
    implements MovieDetailsBloc {}

/// fake movies watchlist bloc
class FakeMovieWatchlistEvent extends Fake implements MovieWatchlistEvent {}

class FakeMovieWatchlistState extends Fake implements MovieWatchlistState {}

class FakeMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}