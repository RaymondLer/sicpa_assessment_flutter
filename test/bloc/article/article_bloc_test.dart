import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sicpa_assessment_flutter/error/custom_exception.dart';
import 'package:sicpa_assessment_flutter/model/search_response.dart';
import 'package:sicpa_assessment_flutter/model/article_type.dart';
import 'package:sicpa_assessment_flutter/model/popular_article_response.dart';
import 'package:sicpa_assessment_flutter/model/article_summary.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';

import '../../shared_mocks.mocks.dart';

void main() {
  group('Test Article Bloc', () {
    final MockArticleRepository articleRepositoryTest = MockArticleRepository();
    final MockArticleSummary articleSummary = MockArticleSummary();
    final MockSearchResponse searchResponse = MockSearchResponse();
    final MockPopularArticleResponse mockPopularArticle =
        MockPopularArticleResponse();

    List<SearchResult> docs = [
      SearchResult(
        headline: Headline(
          main: "Barww",
        ),
        pubDate: "02-12-2021",
      )
    ];

    List<Article> results = [
      Article(
        title: "Most viewed facebook",
        publishedDate: "17-07-2022",
      ),
    ];

    late ArticleBloc articleBloc;

    setUp((() {
      articleBloc = ArticleBloc(articleRepositoryTest);
    }));

    blocTest<ArticleBloc, ArticleState>(
      'Test FetchArticleSuccess State',
      build: () {
        when(articleRepositoryTest.searchArticle('film')).thenAnswer((_) async {
          return Right(searchResponse);
        });

        when(searchResponse.docs).thenReturn(docs);

        when(articleSummary.title)
            .thenReturn(searchResponse.docs?[0].headline?.main);
        when(articleSummary.publishDate)
            .thenReturn(searchResponse.docs?[0].pubDate);

        return articleBloc;
      },
      act: (bloc) => bloc.add(const SearchArticle('film')),
      expect: () => <ArticleState>[
        FetchArticleLoading(),
        FetchArticleSuccess(
          [
            ArticleSummary(
              articleSummary.title,
              articleSummary.publishDate,
            ),
          ],
        ),
      ],
    );

    blocTest<ArticleBloc, ArticleState>(
      'Test GetPopularArticleSuccess State',
      build: () {
        when(articleRepositoryTest.fetchPopularArticle(ArticleType.mostViewed))
            .thenAnswer((_) async {
          return Right(mockPopularArticle);
        });

        when(mockPopularArticle.results).thenReturn(results);

        when(articleSummary.title)
            .thenReturn(mockPopularArticle.results?[0].title);
        when(articleSummary.publishDate)
            .thenReturn(mockPopularArticle.results?[0].publishedDate);

        return articleBloc;
      },
      act: (bloc) => bloc.add(const GetArticles(ArticleType.mostViewed)),
      expect: (() => <ArticleState>[
            FetchArticleLoading(),
            FetchArticleSuccess(
              [
                ArticleSummary(
                  articleSummary.title,
                  articleSummary.publishDate,
                ),
              ],
            ),
          ]),
    );

    blocTest<ArticleBloc, ArticleState>(
      'Test FetchArticleFailed State',
      build: () {
        when(articleRepositoryTest.searchArticle('film')).thenAnswer((_) async {
          return const Left(CustomException('Bad Request'));
        });

        when(searchResponse.docs).thenReturn([]);

        return articleBloc;
      },
      act: (bloc) => bloc.add(const SearchArticle('film')),
      expect: () => <ArticleState>[
        FetchArticleLoading(),
        const FetchArticleFailed(CustomException('Bad Request')),
      ],
    );

    blocTest<ArticleBloc, ArticleState>(
      'Test FetchPopularArticle State',
      build: () {
        when(articleRepositoryTest.fetchPopularArticle(ArticleType.mostViewed))
            .thenAnswer((_) async {
          return const Left(CustomException('Bad Request'));
        });

        when(mockPopularArticle.results).thenReturn([]);

        return articleBloc;
      },
      act: (bloc) => bloc.add(const GetArticles(ArticleType.mostViewed)),
      expect: (() => <ArticleState>[
            FetchArticleLoading(),
            const FetchArticleFailed(CustomException('Bad Request')),
          ]),
    );
  });
}
