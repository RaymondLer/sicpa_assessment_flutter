import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sicpa_assessment_flutter/di/service_locator.dart';
import 'package:sicpa_assessment_flutter/error/custom_exception.dart';
import 'package:sicpa_assessment_flutter/model/search_response.dart';
import 'package:sicpa_assessment_flutter/model/article_type.dart';
import 'package:sicpa_assessment_flutter/model/popular_article_response.dart';
import 'package:sicpa_assessment_flutter/respository/article/i_article_repository.dart';

class ArticleRepository implements IArticleRepository {
  @override
  Future<Either<Exception, SearchResponse>> searchArticle(
      String searchField) async {
    try {
      final response = await Dio().get(
          'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=$searchField&api-key=GgYfDGODKeNSeZENzwiTNfIGXZgavlgr');

      return Right(SearchResponse.fromJson(response.data['response']));
    } on Exception catch (error) {
      return Left(CustomException(error.toString()));
    }
  }

  @override
  Future<Either<Exception, PopularArticleResponse>> fetchPopularArticle(
      ArticleType type) async {
    ConnectivityResult connectivityResult =
        await getIt.get<Connectivity>().checkConnectivity();

    String url = '';

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        switch (type) {
          case ArticleType.mostViewed:
            url = 'https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json';
            break;
          case ArticleType.mostShared:
            url =
                "https://api.nytimes.com/svc/mostpopular/v2/shared/1/facebook.json";
            break;
          case ArticleType.mostEmailed:
            url = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json";
            break;
        }

        final response = await Dio(
          BaseOptions(
              contentType: "application/json",
              queryParameters: {"api-key": 'GgYfDGODKeNSeZENzwiTNfIGXZgavlgr'}),
        ).get(url);

        return Right(PopularArticleResponse.fromJson(response.data));
      } on Exception catch (e) {
        return const Left(CustomException('Bad Request'));
      }
    } else {
      return Left(Exception());
    }

    // try {
    //   switch (type) {
    //     case ArticleType.mostViewed:
    //       url = 'https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json';
    //       break;
    //     case ArticleType.mostShared:
    //       url =
    //           "https://api.nytimes.com/svc/mostpopular/v2/shared/1/facebook.json";
    //       break;
    //     case ArticleType.mostEmailed:
    //       url = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json";
    //       break;
    //   }

    //   final response = await Dio(
    //     BaseOptions(
    //         contentType: "application/json",
    //         queryParameters: {"api-key": 'GgYfDGODKeNSeZENzwiTNfIGXZgavlgr'}),
    //   ).get(url);

    //   return PopularArticleResponse.fromJson(response.data);
    // } catch (error) {
    //   print(error);
    // }
  }
}
