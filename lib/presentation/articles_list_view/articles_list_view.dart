import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';
import 'package:sicpa_assessment_flutter/util/strings.dart';

class ArticlesListView extends StatelessWidget {
  final String? title;

  const ArticlesListView({
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? Strings.ARTICLE_LIST_VIEW_TITLE),
          centerTitle: true,
        ),
        body: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is FetchArticleLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchArticleSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ListView.builder(
                  itemCount: state.sharedArticles.length,
                  itemBuilder: ((context, index) {
                    final publishDate = DateFormat('dd-MM-yyyy').format(
                        DateTime.parse(
                            state.sharedArticles[index].publishDate ?? ''));

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.sharedArticles[index].title ?? ''),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(publishDate),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
            if (state is FetchArticleFailed) {
              return const Center(
                child: Text('Something wrong...'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
