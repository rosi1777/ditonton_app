import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';
part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvSeries _searchTv;

  TvSearchBloc(this._searchTv) : super(TvSearchEmpty()) {
    on<TvOnQueryChanged>(_onChangedQuery,
        transformer: _debounce(const Duration(milliseconds: 500)));
  }

  void _onChangedQuery(
    TvOnQueryChanged event,
    Emitter<TvSearchState> emit,
  ) async {
    final query = event.query;
    emit(TvSearchLoading());

    final result = await _searchTv.execute(query);

    result.fold(
      (failure) => emit(TvSearchError(failure.message)),
      (data) => emit(TvSearchHasData(data)),
    );
  }

  EventTransformer<TvOnQueryChanged> _debounce<TvOnQueryChanged>(
          Duration duration) =>
      (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
