import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_popular_tv_series.dart';
part 'popular_tv_state.dart';
part 'popular_tv_event.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvSeries getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(PopularTvEmpty()) {
    on<FetchPopularTv>(_fetchPopularTv);
  }

  void _fetchPopularTv(
      FetchPopularTv event, Emitter<PopularTvState> emit) async {
    emit(PopularTvLoading());
    final result = await getPopularTv.execute();
    result.fold(
      (failure) => emit(PopularTvError(failure.message)),
      (data) => emit(PopularTvHasData(data)),
    );
  }
}
