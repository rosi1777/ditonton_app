import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  MovieDetailsBloc(
      {required this.getMovieDetail,
      required this.getMovieRecommendations,
      required this.saveWatchlist,
      required this.removeWatchlist,
      required this.getWatchListStatus})
      : super((MovieDetailsEmpty())) {
    on<FetchMovieDetails>(_fetchMovieDetail);
    on<AddedWatchlist>(_addedWatchlist);
    on<RemovedWatchlist>(_removedWatchlist);
  }

  void _fetchMovieDetail(
    FetchMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());
    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult =
        await getMovieRecommendations.execute(event.id);
    final status = await getWatchListStatus.execute(event.id);
    detailResult.fold(
      (failure) => emit(MovieDetailsError(failure.message)),
      (detailMovie) {
        emit(MovieDetailsLoading());
        recommendationResult.fold(
          (failure) => emit(MovieDetailsError(failure.message)),
          (recommendationMovies) => emit(
            MovieDetailsHasData(detailMovie, recommendationMovies, status),
          ),
        );
      },
    );
  }

  void _addedWatchlist(
    AddedWatchlist event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());
    final result = await saveWatchlist.execute(event.movieDetail);

    result.fold(
      (failure) => emit(MovieDetailsError(failure.message)),
      (successMessage) => emit(AddWatchlist(successMessage)),
    );
  }

  void _removedWatchlist(
    RemovedWatchlist event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());
    final result = await removeWatchlist.execute(event.movieDetail);

    result.fold(
      (failure) => emit(MovieDetailsError(failure.message)),
      (successMessage) => emit(RemoveWatchlist(successMessage)),
    );
  }
}
