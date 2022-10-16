import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetWatchlistMovies getWatchlistMovies;
  late MovieWatchlistBloc movieWatchlistBloc;

  setUp(() {
    getWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistBloc = MovieWatchlistBloc(
      getWatchlistMovies,
    );
  });

  test('the initial state should be Initial state', () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  group(
    'get watchlist movies test cases',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(FetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(getWatchlistMovies.execute());
          return FetchMovieWatchlist().props;
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(getWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(FetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistError('Server Failure'),
        ],
        verify: (bloc) => MovieWatchlistLoading(),
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([]));
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(FetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistHasData(const []),
        ],
      );
    },
  );
}
