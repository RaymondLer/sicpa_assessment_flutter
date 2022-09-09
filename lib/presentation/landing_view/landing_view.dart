import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sicpa_assessment_flutter/di/service_locator.dart';
import 'package:sicpa_assessment_flutter/model/article_type.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';
import 'package:sicpa_assessment_flutter/util/constants.dart';
import 'package:sicpa_assessment_flutter/util/strings.dart';

class LandingView extends StatelessWidget {
  final String localeName;

  const LandingView({Key? key, required this.localeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.LANDING_VIEW_TITLE),
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
              // Localized
              Text(
                localeName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                Strings.LANDING_SEARCH,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              OutlinedButton(
                onPressed: () {
                  //* Navigation
                  context.push(Constants.SEARCH_ARTICLE_ROUTE);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(Strings.LANDING_SEARCH_ARTICLE),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                Strings.LANDING_POPULAR,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              OutlinedButton(
                onPressed: () {
                  getIt
                      .get<ArticleBloc>()
                      .add(const GetArticles(ArticleType.mostViewed));

                  context.push(Constants.ARTICLE_LIST_MOST_VIEWED_ROUTE);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(Strings.LANDING_MOST_VIEWED),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  getIt
                      .get<ArticleBloc>()
                      .add(const GetArticles(ArticleType.mostShared));

                  context.push(Constants.ARTICLE_LIST_MOST_SHARED_ROUTE);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(Strings.LANDING_MOST_SHARED),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  getIt
                      .get<ArticleBloc>()
                      .add(const GetArticles(ArticleType.mostEmailed));

                  context.push(Constants.ARTICLE_LIST_MOST_EMAILED_ROUTE);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(Strings.LANDING_MOST_EMAILED),
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
