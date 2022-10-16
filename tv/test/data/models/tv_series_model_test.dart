import 'package:tv/data/models/tv_series_model.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2, 3],
      id: 1,
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      name: "name",
      voteAverage: 1,
      voteCount: 1);

  final tTvSeries = TvSeries(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: const [1, 2, 3],
      id: 1,
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      name: "name",
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
