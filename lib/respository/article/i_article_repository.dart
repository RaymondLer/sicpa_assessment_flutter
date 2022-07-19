import 'package:sicpa_assessment_flutter/model/article_type.dart';

abstract class IArticleRepository {
  Future searchArticle(String searchField);

  Future fetchPopularArticle(ArticleType type);
}
