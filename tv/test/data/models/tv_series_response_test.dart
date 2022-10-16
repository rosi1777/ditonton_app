import 'dart:convert';

import 'package:tv/data/models/tv_series_model.dart';
import 'package:tv/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
      backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      firstAirDate: "2022-08-21",
      genreIds: [10765, 18, 10759],
      id: 94997,
      name: "House of the Dragon",
      originalName: "House of the Dragon",
      overview:
          "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
      popularity: 5365.326,
      posterPath: "/1X4h40fcB4WWUmIBK0auT4zRBAV.jpg",
      voteAverage: 8.5,
      voteCount: 1762);
  const tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today_tv.json'));
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
            "backdrop_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
            "first_air_date": "2022-08-21",
            "genre_ids": [10765, 18, 10759],
            "id": 94997,
            "name": "House of the Dragon",
            "original_name": "House of the Dragon",
            "overview":
                "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
            "popularity": 5365.326,
            "poster_path": "/1X4h40fcB4WWUmIBK0auT4zRBAV.jpg",
            "vote_average": 8.5,
            "vote_count": 1762
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
