import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sicpa_assessment_flutter/di/service_locator.dart';
import 'package:sicpa_assessment_flutter/model/article_type.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("NYT"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 52,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              OutlinedButton(
                onPressed: () {
                  //* Navigation
                  context.push('/search_articles');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Search Articles'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Popular',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              OutlinedButton(
                onPressed: () {
                  getIt
                      .get<ArticleBloc>()
                      .add(const GetArticles(ArticleType.mostViewed));

                  context.push('/articles_list?title=Most Viewed Articles');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Most Viewed'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  getIt
                      .get<ArticleBloc>()
                      .add(const GetArticles(ArticleType.mostShared));

                  context.push('/articles_list?title=Most Shared Articles');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Most Shared'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  getIt
                      .get<ArticleBloc>()
                      .add(const GetArticles(ArticleType.mostEmailed));

                  context.push('/articles_list?title=Most Emailed Articles');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Most Emailed'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
