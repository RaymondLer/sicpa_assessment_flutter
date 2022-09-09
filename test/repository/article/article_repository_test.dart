import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sicpa_assessment_flutter/error/custom_exception.dart';
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

    test('Test Search Article Success', () async {
      final searchArticleResponseModel = SearchResponse();

      when(articleRepo.searchArticle('sport')).thenAnswer((_) async {
        return Right(searchArticleResponseModel);
      });

      final response = await articleRepo.searchArticle('sport');

      expect(response, Right(searchArticleResponseModel));
    });

    test('Test Fetch Popular Article Success', () async {
      final popularArticleResponseModel = PopularArticleResponse();

      when(articleRepo.fetchPopularArticle(ArticleType.mostViewed))
          .thenAnswer((_) async {
        return Right(popularArticleResponseModel);
      });

      final response =
          await articleRepo.fetchPopularArticle(ArticleType.mostViewed);

      expect(response, Right(popularArticleResponseModel));
    });

    test('Test Search Article Failed', () async {
      when(articleRepo.searchArticle('')).thenAnswer((_) async {
        return const Left(CustomException('Error'));
      });

      final response = await articleRepo.searchArticle('');

      expect(response, const Left(CustomException('Error')));
    });
  });
}
