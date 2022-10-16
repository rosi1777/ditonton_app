import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_airing_today_tv_series.dart';

import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetAiringTodayTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetAiringTodayTvSeries(mockTvSeriesRepository);
  });

  final tTvSeriess = <TvSeries>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getAiringTodayTvSeries())
        .thenAnswer((_) async => Right(tTvSeriess));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeriess));
  });
}
