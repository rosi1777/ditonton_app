import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie_details_bloc.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;
  late MovieDetailsBloc movieDetailsBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieDetailsBloc = MovieDetailsBloc(
        getMovieDetail: mockGetMovieDetail,
        getMovieRecommendations: mockGetMovieRecommendations,
        saveWatchlist: mockSaveWatchlistMovie,
        removeWatchlist: mockRemoveWatchlistMovie,
        getWatchListStatus: mockGetWatchListStatus);
  });

  test('the initial state should be empty', () {
    expect(movieDetailsBloc.state, MovieDetailsEmpty());
  });

  blocTest<MovieDetailsBloc, MovieDetailsState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetMovieDetail.execute(testId))
          .thenAnswer((_) async => const Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      when(mockGetWatchListStatus.execute(testId))
          .thenAnswer((_) async => true);
      return movieDetailsBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetails(testId)),
    expect: () => [
      MovieDetailsLoading(),
      MovieDetailsHasData(testMovieDetail, testMovieList, true),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(testId));
      return FetchMovieDetails(testId).props;
    },
  );

  blocTest<MovieDetailsBloc, MovieDetailsState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetMovieDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetWatchListStatus.execute(testId))
          .thenAnswer((_) async => false);
      return movieDetailsBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetails(testId)),
    expect: () => [
      MovieDetailsLoading(),
      MovieDetailsError('Server Failure'),
    ],
    verify: (bloc) => MovieDetailsLoading(),
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<MovieDetailsBloc, MovieDetailsState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlistMovie.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Added to watchlist'));
          return movieDetailsBloc;
        },
        act: (bloc) => bloc.add(AddedWatchlist(testMovieDetail)),
        expect: () => [
          MovieDetailsLoading(),
          AddWatchlist('Added to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistMovie.execute(testMovieDetail));
          return AddedWatchlist(testMovieDetail).props;
        },
      );

      blocTest<MovieDetailsBloc, MovieDetailsState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlistMovie.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return movieDetailsBloc;
        },
        act: (bloc) => bloc.add(AddedWatchlist(testMovieDetail)),
        expect: () => [
          MovieDetailsLoading(),
          MovieDetailsError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistMovie.execute(testMovieDetail));
          return AddedWatchlist(testMovieDetail).props;
        },
      );

      blocTest<MovieDetailsBloc, MovieDetailsState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right('Success remove watchlist'));
          return movieDetailsBloc;
        },
        act: (bloc) => bloc.add(RemovedWatchlist(testMovieDetail)),
        expect: () => [
          MovieDetailsLoading(),
          RemoveWatchlist('Success remove watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
          return RemovedWatchlist(testMovieDetail).props;
        },
      );

      blocTest<MovieDetailsBloc, MovieDetailsState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return movieDetailsBloc;
        },
        act: (bloc) => bloc.add(RemovedWatchlist(testMovieDetail)),
        expect: () => [
          MovieDetailsLoading(),
          MovieDetailsError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
          return RemovedWatchlist(testMovieDetail).props;
        },
      );
    },
  );
}
