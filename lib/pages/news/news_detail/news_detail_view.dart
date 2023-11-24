import 'package:flutter/material.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/languages/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../model/news_model.dart';

class NewsDetailView extends StatefulWidget {
  const NewsDetailView({super.key, required this.news});

  final NewsModel news;

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends BaseState<NewsDetailView> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text(LocaleKeys.news_contents.translate)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              NavigationService.instance.navigateToPop();
            },
          ),
        ),
        body: Padding(
          padding: paddingConstants.basePadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: borderConstants.borderRadiusMediumAll,
                  child: Image.network(
                    widget.news.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    LocaleKeys.base_lang.translate == 'tr'
                        ? widget.news.title
                        : widget.news.titleEn,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto')),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    LocaleKeys.base_lang.translate == 'tr'
                        ? widget.news.description
                        : widget.news.descriptionEn,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto')),
              ],
            ),
          ),
        ));
  }
}
