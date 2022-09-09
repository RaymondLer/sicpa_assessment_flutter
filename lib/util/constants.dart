class Constants {
  // Go Router declarative routing path
  static const SEARCH_ARTICLE_PATH = 'search_articles';
  static const ARTICLE_LIST_PATH = 'articles_list';

  // Routes
  static const SEARCH_ARTICLE_ROUTE = '/search_articles';
  static const ARTICLE_LIST_ROUTE = '/articles_list';

  // Pass queryParam routes
  static const ARTICLE_LIST_MOST_VIEWED_ROUTE =
      '/articles_list?title=Most Viewed Articles';
  static const ARTICLE_LIST_MOST_SHARED_ROUTE =
      '/articles_list?title=Most Shared Articles';
  static const ARTICLE_LIST_MOST_EMAILED_ROUTE =
      '/articles_list?title=Most Emailed Articles';
  static const ARTICLE_LIST_SEARCH_ROUTE = '/articles_list?title=Search: ';

  // Hive
  static const HIVE_BOX_SEARCH_HISTORY = 'search_history';
}
