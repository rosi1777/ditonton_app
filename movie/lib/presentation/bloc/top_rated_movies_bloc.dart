import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
part 'top_rated_movies_state.dart';
part 'top_rated_movies_event.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>(_fetchTopRatedMovies);
  }

  void _fetchTopRatedMovies(
      FetchTopRatedMovies event, Emitter<TopRatedMoviesState> emit) async {
    emit(TopRatedMoviesLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(TopRatedMoviesError(failure.message)),
      (data) => emit(TopRatedMoviesHasData(data)),
    );
  }
}
