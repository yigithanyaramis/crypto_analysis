import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';
import '../../core/constants/navigation/navigation_constants.dart';
import '../../core/extension/string_extension.dart';
import '../../core/init/languages/locale_keys.g.dart';
import '../../core/init/navigation/navigation_service.dart';
import 'model/news_model.dart';
import 'news_view_model.dart';

const double _mediumHeightWidth = 10;

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends BaseState<NewsView> {
  late final NewsViewModel _viewModel;
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<NewsViewModel>(
      viewModel: NewsViewModel(),
      onModelReady: (model) {
        _viewModel = model;
      },
      onPageBuilder: (context, value) => buildBody(),
    );
  }

  // Ekranın ana yapısını oluşturan metot
  Widget buildBody() {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            // Çeviri işlemi için LocaleKeys kullanılıyor
            '${LocaleKeys.news_news.translate} - ${LocaleKeys.news_grapichs.translate}',
          ),
        ),
      ),
      body: Padding(
        padding: paddingConstants.basePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenu(),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  Observer(builder: (context) => _buildListView(0)),
                  Observer(builder: (context) => _buildListView(1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Menüyü oluşturan metot
  Container _buildMenu() {
    return Container(
      margin: paddingConstants.allLowPadding,
      decoration: BoxDecoration(
        color: colorConstants.primaryColor,
        borderRadius: borderConstants.borderRadiusLowAll,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  // Sayfa geçiş animasyonu ile ilgili ayarlar kullanılıyor
                  _pageController.animateToPage(0,
                      curve: Curves.easeInOut,
                      duration: durationConstants.highDuration);
                },
                child: Text(
                  // Çeviri işlemi için LocaleKeys kullanılıyor ve metin büyük harflere dönüştürülüyor
                  LocaleKeys.news_news.translate.toUpperCase(),
                  style: TextStyle(color: colorConstants.secondaryColor),
                ),
              ),
            ),
            const VerticalDivider(color: Colors.grey),
            Expanded(
              child: TextButton(
                onPressed: () {
                  // Sayfa geçiş animasyonu ile ilgili ayarlar kullanılıyor
                  _pageController.animateToPage(1,
                      curve: Curves.easeInOut,
                      duration: durationConstants.highDuration);
                },
                child: Text(
                  // Çeviri işlemi için LocaleKeys kullanılıyor ve metin büyük harflere dönüştürülüyor
                  LocaleKeys.news_grapichs.translate.toUpperCase(),
                  style: TextStyle(color: colorConstants.secondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Haber veya grafik listesini oluşturan metot
  Widget _buildListView(int selectIndex) {
    List<NewsModel> news;
    if (selectIndex == 0) {
      news = _viewModel.newsList;
    } else {
      news = _viewModel.graphicsList;
    }
    return ListView.builder(
      itemCount: news.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: _mediumHeightWidth, horizontal: 2),
          padding: paddingConstants.allLowPadding,
          decoration: BoxDecoration(
            color: colorConstants.primaryColor,
            borderRadius: borderConstants.borderRadiusMediumAll,
          ),
          child: InkWell(
            onTap: () {
              // Haber detay sayfasına yönlendirme yapılıyor
              NavigationService.instance.navigateToPage(
                path: NavigationConstants.newsDetailView,
                data: news[index],
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: borderConstants.borderRadiusMediumAll,
                  child: Image.network(
                    news[index].photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: _mediumHeightWidth),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    // Dil seçeneğine göre başlık metni gösteriliyor
                    LocaleKeys.base_lang.translate == 'tr'
                        ? news[index].title
                        : news[index].titleEn,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    // Çeviri işlemi için LocaleKeys kullanılıyor
                    '${LocaleKeys.news_review.translate} >',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
