import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:sicpa_assessment_flutter/di/service_locator.dart';
import 'package:sicpa_assessment_flutter/presentation/articles_list_view/articles_list_view.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';
import 'package:sicpa_assessment_flutter/presentation/landing_view/landing_view.dart';
import 'package:sicpa_assessment_flutter/presentation/search_articles_view/search_articles_view.dart';
import 'package:sicpa_assessment_flutter/util/constants.dart';
import 'package:sicpa_assessment_flutter/util/strings.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  setup();

  BlocOverrides.runZoned(
      blocObserver: SimpleBlocObserver(), () => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            final localeName = AppLocalizations.of(context).helloWorld;

            return LandingView(
              localeName: localeName,
            );
          },
          routes: [
            // Search Article sub-route
            GoRoute(
              path: Constants.SEARCH_ARTICLE_PATH,
              builder: (context, state) => const SearchArticlesView(),
            ),
            // Article List sub-route
            GoRoute(
              path: Constants.ARTICLE_LIST_PATH,
              builder: (context, state) {
                final title = state.queryParams['title']; // may be null

                return ArticlesListView(title: title);
              },
            ),
          ]),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (_) => getIt.get<ArticleBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: Strings.APP_TITLE,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('zh', 'CN'),
        ],
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }
}
