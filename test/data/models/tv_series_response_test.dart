import 'dart:convert';

import 'package:tv/data/models/tv_series_model.dart';
import 'package:tv/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      backdropPath: "/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg",
      firstAirDate: "2019-06-16",
      genreIds: [18],
      id: 85552,
      originalName: "Euphoria",
      overview:
          "A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.",
      popularity: 4322.903,
      posterPath: "/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg",
      name: "Euphoria",
      voteAverage: 8.4,
      voteCount: 5654);
  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg",
            "first_air_date": "2019-06-16",
            "genre_ids": [18],
            "id": 85552,
            "original_name": "Euphoria",
            "overview":
                "A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.",
            "popularity": 4322.903,
            "poster_path": "/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg",
            "name": "Euphoria",
            "vote_average": 8.4,
            "vote_count": 5654
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
