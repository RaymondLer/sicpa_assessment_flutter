import 'package:mockito/annotations.dart';
import 'package:sicpa_assessment_flutter/model/search_response.dart';
import 'package:sicpa_assessment_flutter/model/popular_article_response.dart';
import 'package:sicpa_assessment_flutter/model/article_summary.dart';
import 'package:sicpa_assessment_flutter/respository/article/article_repository.dart';

@GenerateMocks(
    [ArticleRepository, ArticleSummary, SearchResponse, PopularArticleResponse])
void main() {}
