import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sicpa_assessment_flutter/model/search_response.dart';
import 'package:sicpa_assessment_flutter/model/article_type.dart';
import 'package:sicpa_assessment_flutter/model/popular_article_response.dart';
import 'package:sicpa_assessment_flutter/model/article_summary.dart';
import 'package:sicpa_assessment_flutter/respository/article/i_article_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final IArticleRepository _articleRepository;

  ArticleBloc(this._articleRepository) : super(ArticleInitial()) {
    List<ArticleSummary> sharedArticles = [];

    on<SearchArticle>((event, emit) async {
      emit(FetchArticleLoading());

      final article = await _articleRepository.searchArticle(event.searchField);

      article.fold((failure) {
        return emit(FetchArticleFailed(failure));
      }, (article) {
        if (article.docs != null && article.docs!.isNotEmpty) {
          // sharedArticles = [];
          // for (var e in article.docs!) {
          //   sharedArticles.add(ArticleSummary(e.headline?.main, e.pubDate));
          // }

          Convert(article.docs).toArticleSummaryList();

          return emit(FetchArticleSuccess(
              Convert(article.docs).toArticleSummaryList()));
        }
      });

      // if (article.docs != null && article.docs!.isNotEmpty) {
      //   sharedArticles = [];
      //   for (var e in article.docs!) {
      //     sharedArticles.add(ArticleSummary(e.headline?.main, e.pubDate));
      //   }

      //   return emit(FetchArticleSuccess(sharedArticles));
      // } else {
      //   emit(FetchArticleFailed(Exception()));
      // }
    });

    on<GetArticles>((event, emit) async {
      emit(FetchArticleLoading());

      final popularArticle =
          await _articleRepository.fetchPopularArticle(event.type);

      popularArticle.fold((failure) {
        return emit(FetchArticleFailed(failure));
      }, (popularArticle) {
        if (popularArticle.results != null &&
            popularArticle.results!.isNotEmpty) {
          sharedArticles = [];
          for (var e in popularArticle.results!) {
            sharedArticles.add(ArticleSummary(e.title, e.publishedDate));
          }

          return emit(FetchArticleSuccess(sharedArticles));
        }
      });

      // PopularArticleResponse popularArticle =
      //     await _articleRepository.fetchPopularArticle(event.type);

      // if (popularArticle.results != null &&
      //     popularArticle.results!.isNotEmpty) {
      //   sharedArticles = [];
      //   for (var e in popularArticle.results!) {
      //     sharedArticles.add(ArticleSummary(e.title, e.publishedDate));
      //   }

      //   emit(FetchArticleSuccess(sharedArticles));
      // } else {
      //   emit(const FetchArticleFailed(''));
      // }
    });
  }
}
