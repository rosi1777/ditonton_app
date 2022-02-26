part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {}

class MovieWatchlistEmpty extends MovieWatchlistState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistLoading extends MovieWatchlistState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> result;

  MovieWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}
