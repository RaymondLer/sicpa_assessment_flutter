import 'package:get_it/get_it.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';
import 'package:sicpa_assessment_flutter/respository/article/article_repository.dart';
import 'package:sicpa_assessment_flutter/respository/article/i_article_repository.dart';

final getIt = GetIt.instance;

Future setup() async {
  getIt.registerLazySingleton<IArticleRepository>(() => ArticleRepository());

  getIt.registerLazySingleton<ArticleBloc>(
      () => ArticleBloc(getIt.get<IArticleRepository>()));
}
