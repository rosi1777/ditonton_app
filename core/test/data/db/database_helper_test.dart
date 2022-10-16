import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
  });

  final testMovieTableId = testMovieTable.id;
  final testTvSeriesTableId = testTvSeriesTable.id;

  group('Movie test on db', () {
    test('should return movie id when inserting new movie', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result = await mockDatabaseHelper.insertWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return movie id when deleting a movie', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result = await mockDatabaseHelper.removeWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return movie Ddtail Table when getting movie by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId))
          .thenAnswer((_) async => testMovieTable.toJson());
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId);
      // assert
      expect(result, testMovieTable.toJson());
    });

    test('should return null when getting movie by id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId);
      // assert
      expect(result, null);
    });

    test('should return list of movie map when getting watchlist movies',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistMovies();
      // assert
      expect(result, [testMovieMap]);
    });
  });

  group('Tv Series test on db', () {
    test('should return tv series id when inserting new tv show', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => testTvSeriesTableId);
      // act
      final result =
          await mockDatabaseHelper.insertWatchlistTv(testTvSeriesTable);
      // assert
      expect(result, testTvSeriesTableId);
    });

    test('should return tv series id when deleting a tv show', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => testTvSeriesTableId);
      // act
      final result =
          await mockDatabaseHelper.removeWatchlistTv(testTvSeriesTable);
      // assert
      expect(result, testTvSeriesTableId);
    });

    test(
        'should return Tv Series Detail Table when getting tv show by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(testTvSeriesTableId))
          .thenAnswer((_) async => testTvSeriesTable.toJson());
      // act
      final result =
          await mockDatabaseHelper.getTvSeriesById(testTvSeriesTableId);
      // assert
      expect(result, testTvSeriesTable.toJson());
    });

    test('should return null when getting tv show by id is not found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(testTvSeriesTableId))
          .thenAnswer((_) async => null);
      // act
      final result =
          await mockDatabaseHelper.getTvSeriesById(testTvSeriesTableId);
      // assert
      expect(result, null);
    });

    test('should return list of tv series map when getting watchlist tv shows',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistTvSeries();
      // assert
      expect(result, [testTvSeriesMap]);
    });
  });
}
