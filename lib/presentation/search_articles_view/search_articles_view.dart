import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sicpa_assessment_flutter/di/service_locator.dart';
import 'package:sicpa_assessment_flutter/hive/search_box.dart';
import 'package:sicpa_assessment_flutter/model/searched_history.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';
import 'package:sicpa_assessment_flutter/util/constants.dart';
import 'package:sicpa_assessment_flutter/util/strings.dart';

class SearchArticlesView extends StatefulWidget {
  const SearchArticlesView({Key? key}) : super(key: key);

  @override
  State<SearchArticlesView> createState() => _SearchArticlesViewState();
}

class _SearchArticlesViewState extends State<SearchArticlesView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  List<SearchedHistory> searchHistoryList = [];
  bool validate = false;

  @override
  void initState() {
    super.initState();

    getSearchHistory();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.SEARCH_ARTICLE_VIEW_TITLE),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  validator: ((value) {
                    return value!.isEmpty ? 'Search cannot be empty' : null;
                  }),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search articles here...',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: buildSearchHistoryListView(searchHistoryList),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final String query = controller.text;

                      getIt.get<SearchBox>().addSearch(query);

                      getIt.get<ArticleBloc>().add(SearchArticle(query));

                      context.go(Constants.ARTICLE_LIST_SEARCH_ROUTE + query);
                    }
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getSearchHistory() {
    final Box box = getIt.get<SearchBox>().searchHistoryBox;

    if (box.values.isNotEmpty) {
      for (var e in box.values) {
        searchHistoryList.add(SearchedHistory(e));
      }
    }
  }

  Widget buildSearchHistoryListView(List<SearchedHistory> searchList) {
    if (searchList.isEmpty) {
      return Container();
    } else {
      return ListView.builder(
        itemCount: searchList.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          final searched = searchList[index];

          return ListTile(
            title: Text(searched.searchedText),
            onTap: (() {
              controller.text = searched.searchedText;
            }),
          );
        }),
      );
    }
  }
}
