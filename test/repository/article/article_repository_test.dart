import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sicpa_assessment_flutter/model/article_type.dart';
import 'package:sicpa_assessment_flutter/model/search_response.dart';
import 'package:sicpa_assessment_flutter/model/popular_article_response.dart';

import '../../shared_mocks.mocks.dart';

void main() {
  group('Article Repository', () {
    late MockArticleRepository articleRepo;

    setUp(() {
      articleRepo = MockArticleRepository();
    });

    test('Test searchArticle()', () async {
      final articleModel = Article();

      when(articleRepo.searchArticle('sport')).thenAnswer((_) async {
        return articleModel;
      });

      final response = await articleRepo.searchArticle('sport');

      expect(response, isA<Article>());
      expect(response, articleModel);
    });

    test('Test fetchPopularArticle()', () async {
      final popularArticleModel = PopularArticleResponse();

      when(articleRepo.fetchPopularArticle(ArticleType.mostViewed))
          .thenAnswer((_) async {
        return popularArticleModel;
      });

      final response =
          await articleRepo.fetchPopularArticle(ArticleType.mostViewed);

      expect(response, isA<PopularArticleResponse>());
      expect(response, popularArticleModel);
    });
  });
}
