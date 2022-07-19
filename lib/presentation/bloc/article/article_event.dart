part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class SearchArticle extends ArticleEvent {
  final String searchField;

  const SearchArticle(this.searchField);

  @override
  List<Object> get props => [searchField];
}

class GetArticles extends ArticleEvent {
  final ArticleType type;

  const GetArticles(this.type);

  @override
  List<Object> get props => [type];
}
