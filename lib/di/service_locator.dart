import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sicpa_assessment_flutter/hive/search_box.dart';
import 'package:sicpa_assessment_flutter/model/searched_history.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';
import 'package:sicpa_assessment_flutter/respository/article/article_repository.dart';
import 'package:sicpa_assessment_flutter/respository/article/i_article_repository.dart';
import 'package:sicpa_assessment_flutter/util/constants.dart';

final getIt = GetIt.instance;

Future setup() async {
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(SearchedHistoryAdapter());

  final box = await Hive.openBox(Constants.HIVE_BOX_SEARCH_HISTORY);

  getIt.registerLazySingleton<IArticleRepository>(() => ArticleRepository());

  getIt.registerLazySingleton<ArticleBloc>(
      () => ArticleBloc(getIt.get<IArticleRepository>()));

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt
      .registerLazySingleton<SearchBox>(() => SearchBox(searchHistoryBox: box));
}
