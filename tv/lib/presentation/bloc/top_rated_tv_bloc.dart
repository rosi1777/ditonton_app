import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart';
part 'top_rated_tv_state.dart';
part 'top_rated_tv_event.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvSeries getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TopRatedTvEmpty()) {
    on<FetchTopRatedTv>(_fetchTopRatedTv);
  }

  void _fetchTopRatedTv(
      FetchTopRatedTv event, Emitter<TopRatedTvState> emit) async {
    emit(TopRatedTvLoading());
    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) => emit(TopRatedTvError(failure.message)),
      (data) => emit(TopRatedTvHasData(data)),
    );
  }
}
