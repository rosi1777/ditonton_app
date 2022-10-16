import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_series.dart';
part 'tv_watchlist_state.dart';
part 'tv_watchlist_event.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTvSeries getTvWatchlist;

  TvWatchlistBloc(this.getTvWatchlist) : super(TvWatchlistEmpty()) {
    on<FetchTvWatchlist>(_fetchTvWatchlist);
  }

  void _fetchTvWatchlist(
      FetchTvWatchlist event, Emitter<TvWatchlistState> emit) async {
    emit(TvWatchlistLoading());
    final result = await getTvWatchlist.execute();
    result.fold(
      (failure) => emit(TvWatchlistError(failure.message)),
      (data) => emit(TvWatchlistHasData(data)),
    );
  }
}
