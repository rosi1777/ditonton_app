import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_airing_today_tv_series.dart';
part 'airing_today_tv_event.dart';
part 'airing_today_tv_state.dart';

class AiringTodayTvBloc extends Bloc<AiringTodayTvEvent, AiringTodayTvState> {
  final GetAiringTodayTvSeries getAiringTodayTv;

  AiringTodayTvBloc(this.getAiringTodayTv) : super(AiringTodayTvEmpty()) {
    on<FetchAiringTodayTv>(_fetchAiringTodayTv);
  }

  void _fetchAiringTodayTv(
      FetchAiringTodayTv event, Emitter<AiringTodayTvState> emit) async {
    emit(AiringTodayTvLoading());
    final result = await getAiringTodayTv.execute();
    result.fold(
      (failure) => emit(AiringTodayTvError(failure.message)),
      (data) => emit(AiringTodayTvHasData(data)),
    );
  }
}
