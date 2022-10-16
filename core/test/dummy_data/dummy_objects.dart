import 'package:core/domain/entities/genre.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:tv/data/models/tv_series_table.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
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

final testMovieList = [testMovie];

final testTvSeries = TvSeries(
    backdropPath: "/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg",
    firstAirDate: "2019-06-16",
    genreIds: const [18],
    id: 85552,
    originalName: "Euphoria",
    overview:
        "A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.",
    popularity: 4322.903,
    posterPath: "/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg",
    name: "Euphoria",
    voteAverage: 8.4,
    voteCount: 5654);

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
    backdropPath: "backdropPath",
    firstAirDate: "firstAirDate",
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: "originalName",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    name: "name",
    voteAverage: 1,
    voteCount: 1);

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvSeries = TvSeries.watchlist(
    id: 1, overview: "overview", posterPath: "posterPath", name: "name");

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvSeriesTable = TvSeriesTable(
    id: 1, name: "name", posterPath: "posterPath", overview: "overview");

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeriesMap = {
  "id": 1,
  "name": "name",
  "posterPath": "posterPath",
  "overview": "overview"
};
