import 'package:dio/dio.dart';
import 'package:sicpa_assessment_flutter/model/search_response.dart';
import 'package:sicpa_assessment_flutter/model/article_type.dart';
import 'package:sicpa_assessment_flutter/model/popular_article_response.dart';
import 'package:sicpa_assessment_flutter/respository/article/i_article_repository.dart';

class ArticleRepository implements IArticleRepository {
  @override
  Future searchArticle(String searchField) async {
    try {
      final response = await Dio().get(
          'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=$searchField&api-key=GgYfDGODKeNSeZENzwiTNfIGXZgavlgr');

      return SearchResponse.fromJson(response.data['response']);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future fetchPopularArticle(ArticleType type) async {
    String url = '';

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

      return PopularArticleResponse.fromJson(response.data);
    } catch (error) {
      print(error);
    }
  }
}
