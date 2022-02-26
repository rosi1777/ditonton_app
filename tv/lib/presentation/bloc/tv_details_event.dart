part of 'tv_details_bloc.dart';

abstract class TvDetailsEvent extends Equatable {}

class FetchTvDetails extends TvDetailsEvent {
  final int id;

  FetchTvDetails(this.id);

  @override
  List<Object> get props => [id];
}

class AddedWatchlist extends TvDetailsEvent {
  final TvSeriesDetail tvSeriesDetail;

  AddedWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemovedWatchlist extends TvDetailsEvent {
  final TvSeriesDetail tvSeriesDetail;

  RemovedWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
