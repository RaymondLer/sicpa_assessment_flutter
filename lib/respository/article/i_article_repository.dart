import 'package:dartz/dartz.dart';
import 'package:sicpa_assessment_flutter/model/article_type.dart';

import '../../model/search_response.dart';
import '../../model/popular_article_response.dart';

abstract class IArticleRepository {
  Future<Either<Exception, SearchResponse>> searchArticle(String searchField);

  Future<Either<Exception, PopularArticleResponse>> fetchPopularArticle(
      ArticleType type);
}
