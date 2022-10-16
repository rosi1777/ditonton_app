import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
part 'movie_watchlist_state.dart';
part 'movie_watchlist_event.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getMovieWatchlist;

  MovieWatchlistBloc(this.getMovieWatchlist) : super(MovieWatchlistEmpty()) {
    on<FetchMovieWatchlist>(_fetchMovieWatchlist);
  }

  void _fetchMovieWatchlist(
      FetchMovieWatchlist event, Emitter<MovieWatchlistState> emit) async {
    emit(MovieWatchlistLoading());
    final result = await getMovieWatchlist.execute();
    result.fold(
      (failure) => emit(MovieWatchlistError(failure.message)),
      (data) => emit(MovieWatchlistHasData(data)),
    );
  }
}
