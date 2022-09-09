import 'package:hive/hive.dart';

class SearchBox {
  final Box searchHistoryBox;

  SearchBox({required this.searchHistoryBox});

  Future addSearch(String query) async {
    final containsQuery = searchHistoryBox.values.contains(query);

    if (containsQuery == false) {
      await searchHistoryBox.add(query);
    }
  }
}
