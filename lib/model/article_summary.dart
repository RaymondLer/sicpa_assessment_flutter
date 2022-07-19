import 'package:equatable/equatable.dart';

// Model class for UI.
class ArticleSummary extends Equatable {
  String? title;
  String? publishDate;

  ArticleSummary(this.title, this.publishDate);

  @override
  List<Object?> get props => [title, publishDate];
}
