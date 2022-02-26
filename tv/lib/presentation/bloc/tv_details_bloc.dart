import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_recomendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_series.dart';
part 'tv_details_event.dart';
part 'tv_details_state.dart';

class TvDetailsBloc extends Bloc<TvDetailsEvent, TvDetailsState> {
  final GetTvSeriesDetail getTvDetail;
  final GetTvSeriesRecommendations getTvRecommendations;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;
  final GetWatchListStatusTvSeries getWatchListStatus;

  TvDetailsBloc(
      {required this.getTvDetail,
      required this.getTvRecommendations,
      required this.saveWatchlist,
      required this.removeWatchlist,
      required this.getWatchListStatus})
      : super((TvDetailsEmpty())) {
    on<FetchTvDetails>(_fetchTvDetail);
    on<AddedWatchlist>(_addedWatchlist);
    on<RemovedWatchlist>(_removedWatchlist);
  }

  void _fetchTvDetail(
    FetchTvDetails event,
    Emitter<TvDetailsState> emit,
  ) async {
    emit(TvDetailsLoading());
    final detailResult = await getTvDetail.execute(event.id);
    final recommendationResult = await getTvRecommendations.execute(event.id);
    final status = await getWatchListStatus.execute(event.id);
    detailResult.fold(
      (failure) => emit(TvDetailsError(failure.message)),
      (detailTv) {
        emit(TvDetailsLoading());
        recommendationResult.fold(
          (failure) => emit(TvDetailsError(failure.message)),
          (recommendationTvs) => emit(
            TvDetailsHasData(detailTv, recommendationTvs, status),
          ),
        );
      },
    );
  }

  void _addedWatchlist(
    AddedWatchlist event,
    Emitter<TvDetailsState> emit,
  ) async {
    emit(TvDetailsLoading());
    final result = await saveWatchlist.execute(event.tvSeriesDetail);

    result.fold(
      (failure) => emit(TvDetailsError(failure.message)),
      (successMessage) => emit(AddWatchlist(successMessage)),
    );
  }

  void _removedWatchlist(
    RemovedWatchlist event,
    Emitter<TvDetailsState> emit,
  ) async {
    emit(TvDetailsLoading());
    final result = await removeWatchlist.execute(event.tvSeriesDetail);

    result.fold(
      (failure) => emit(TvDetailsError(failure.message)),
      (successMessage) => emit(RemoveWatchlist(successMessage)),
    );
  }
}
