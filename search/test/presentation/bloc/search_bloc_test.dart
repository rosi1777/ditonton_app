import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/movie/search_movies.dart';
import 'package:search/presentation/bloc/movie/movie_search_bloc.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MoviesSearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = MoviesSearchBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, MoviesSearchEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  group('search movies', () {
    test('intial state should be on page', () {
      expect(searchBloc.state, MoviesSearchEmpty());
    });

    blocTest<MoviesSearchBloc, MoviesSearchState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(MoviesOnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      verify: (_) => MoviesOnQueryChanged(tQuery).props,
      expect: () => [
        MoviesSearchLoading(),
        MoviesSearchHasData(tMovieList),
      ],
    );

    blocTest<MoviesSearchBloc, MoviesSearchState>(
      'should emit [Loading, HasData] when data is gotten successfully but it return empty list',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => const Right([]));
        return searchBloc;
      },
      act: (bloc) => bloc.add(MoviesOnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      verify: (_) => MoviesOnQueryChanged(tQuery).props,
      expect: () => [
        MoviesSearchLoading(),
        MoviesSearchHasData(const []),
      ],
    );

    blocTest<MoviesSearchBloc, MoviesSearchState>(
      'Should emit [Loading, Error] when data is gotten is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(MoviesOnQueryChanged(tQuery)),
      verify: (_) => MoviesOnQueryChanged(tQuery).props,
      expect: () => [
        MoviesSearchLoading(),
        MoviesSearchError('Server Failure'),
      ],
    );
  });
}
