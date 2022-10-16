import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import '../../helpers/page_test_helper.dart';
import '../../../../core/test/dummy_data/dummy_objects.dart';

void main() {
  late FakePopularMoviesBloc fakePopularMoviesBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
    fakePopularMoviesBloc = FakePopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>(
      create: (_) => fakePopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakePopularMoviesBloc.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display AppBar, ListView, and popular page when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Popular Movies'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'Failed';

    when(() => fakePopularMoviesBloc.state)
        .thenReturn(PopularMoviesError(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}