import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../core/init/network/services/news_service.dart';
import 'model/news_model.dart';

part 'news_view_model.g.dart';

class NewsViewModel = _NewsViewModelBase with _$NewsViewModel;

abstract class _NewsViewModelBase with Store {
  late final NewsService _newsService;

  // Başlatıcı metodunda NewsService'i başlatın
  _NewsViewModelBase() : _newsService = NewsService.instance {
    fetchNewsAll();
    fetchGraphicsAll();
  }

  // Haber listesi için bir observable liste tanımlayın
  @observable
  ObservableList<NewsModel> newsList = ObservableList<NewsModel>();

  // Grafik listesi için bir observable liste tanımlayın
  @observable
  ObservableList<NewsModel> graphicsList = ObservableList<NewsModel>();

  // Haberleri getiren metot
  @action
  Future<void> fetchNewsAll() async {
    var response = await _newsService.fetchNewsAll();

    // Başarılı bir yanıt alındıysa listeyi temizleyin ve verileri ekleyin
    if (response is List) {
      newsList.clear();
      newsList.addAll(response.map((match) => NewsModel.fromJson(match)));
    } else {
      handleFetchError(response);
    }
  }

  // Grafikleri getiren metot
  @action
  Future<void> fetchGraphicsAll() async {
    var response = await _newsService.fetchGraphicsAll();

    // Başarılı bir yanıt alındıysa listeyi temizleyin ve verileri ekleyin
    if (response is List) {
      graphicsList.clear();
      graphicsList.addAll(response.map((match) => NewsModel.fromJson(match)));
    } else {
      handleFetchError(response);
    }
  }

  // Hata işleme metodu
  void handleFetchError(dynamic response) {
    if (response is Map && response.containsKey('error')) {
      final errorMessage = response['error'] as String;
      if (kDebugMode) {
        debugPrint('Veriler getirilirken hata oluştu: $errorMessage');
      }
    }
  }
}
