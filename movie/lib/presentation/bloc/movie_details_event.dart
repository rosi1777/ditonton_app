part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {}

class FetchMovieDetails extends MovieDetailsEvent {
  final int id;

  FetchMovieDetails(this.id);

  @override
  List<Object> get props => [id];
}

class AddedWatchlist extends MovieDetailsEvent {
  final MovieDetail movieDetail;

  AddedWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemovedWatchlist extends MovieDetailsEvent {
  final MovieDetail movieDetail;

  RemovedWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
