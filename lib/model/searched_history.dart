import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'searched_history.g.dart';

@HiveType(typeId: 0)
class SearchedHistory extends Equatable {
  @HiveField(0)
  final String searchedText;

  const SearchedHistory(this.searchedText);

  @override
  List<Object?> get props => [searchedText];
}
