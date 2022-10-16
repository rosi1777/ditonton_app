import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import '../models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlistTv(TvSeriesTable tvSerie);
  Future<String> removeWatchlistTv(TvSeriesTable tvSerie);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTv(TvSeriesTable tvSerie) async {
    try {
      await databaseHelper.insertWatchlistTv(tvSerie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvSeriesTable tvSerie) async {
    try {
      await databaseHelper.removeWatchlistTv(tvSerie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }
}
