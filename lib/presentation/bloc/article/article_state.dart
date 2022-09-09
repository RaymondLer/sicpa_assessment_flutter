part of 'article_bloc.dart';

@immutable
abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class FetchArticleLoading extends ArticleState {}

class FetchArticleSuccess extends ArticleState {
  final List<ArticleSummary> sharedArticles;

  const FetchArticleSuccess(this.sharedArticles);

  @override
  List<Object> get props => [sharedArticles];
}

class FetchArticleFailed extends ArticleState {
  final Exception message;

  const FetchArticleFailed(this.message);

  @override
  List<Object> get props => [message];
}
