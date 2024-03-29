import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetNowPlayingMovies usecase;
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;

  setUp(() {
    usecase = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingMoviesBloc.state, NowPlayingMoviesEmpty());
  });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return FetchNowPlayingMovies().props;
    },
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingMoviesLoading(),
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesHasData(const []),
    ],
  );
}