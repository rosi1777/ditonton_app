import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_details_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import '../../helpers/page_test_helper.dart';
import '../../../../core/test/dummy_data/dummy_objects.dart';

void main() {
  late FakeMovieDetailsBloc fakeMovieDetailsBloc;
  late FakeMovieWatchlistBloc fakeMovieWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailsEvent());
    registerFallbackValue(FakeMovieDetailsState());
    fakeMovieDetailsBloc = FakeMovieDetailsBloc();

    registerFallbackValue(FakeMovieWatchlistEvent());
    registerFallbackValue(FakeMovieWatchlistState());
    fakeMovieWatchlistBloc = FakeMovieWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailsBloc>(
          create: (_) => fakeMovieDetailsBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (_) => fakeMovieWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeMovieDetailsBloc.close();
    fakeMovieWatchlistBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display progress bar when start to retrieve data',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailsBloc.state).thenReturn(MovieDetailsLoading());
    when(() => fakeMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistLoading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailsBloc.state)
        .thenReturn(MovieDetailsHasData(testMovieDetail, testMovieList, true));
    when(() => fakeMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistHasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailsBloc.state)
        .thenReturn(MovieDetailsHasData(testMovieDetail, testMovieList, false));

    final watchlistButtonIconFinder = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailsBloc.state)
        .thenReturn(MovieDetailsHasData(testMovieDetail, testMovieList, true));

    final watchlistButtonIconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });
}