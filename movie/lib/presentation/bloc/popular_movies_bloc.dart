import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
part 'popular_movies_state.dart';
part 'popular_movies_event.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>(_fetchPopularMovies);
  }

  void _fetchPopularMovies(
      FetchPopularMovies event, Emitter<PopularMoviesState> emit) async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) => emit(PopularMoviesError(failure.message)),
      (data) => emit(PopularMoviesHasData(data)),
    );
  }
}
