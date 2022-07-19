import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sicpa_assessment_flutter/di/service_locator.dart';
import 'package:sicpa_assessment_flutter/presentation/bloc/article/article_bloc.dart';

class SearchArticlesView extends StatefulWidget {
  const SearchArticlesView({Key? key}) : super(key: key);

  @override
  State<SearchArticlesView> createState() => _SearchArticlesViewState();
}

class _SearchArticlesViewState extends State<SearchArticlesView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  bool validate = false;

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
          title: const Text("Search"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
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
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      getIt
                          .get<ArticleBloc>()
                          .add(SearchArticle(controller.text));

                      context.push(
                          '/articles_list?title=Search: ${controller.text}');
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
}
