import 'package:mobx/mobx.dart';

import '../../core/init/network/services/app_service.dart';
import '../../core/init/network/services/signal_service.dart';
import '../../product/model/contact_model.dart';
import '../../product/model/signal_model.dart';
import 'market_cap_model.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final AppService _appService = AppService.instance;
  final SignalService _signalService = SignalService.instance;

  _HomeViewModelBase() {
    fetchInitialData();
  }

  // İlk veri çekme işlemlerini gruplandırır.
  @action
  Future<void> fetchInitialData() async {
    await Future.wait([
      fetchMarketCap(),
      fetchFreeSignalLast(),
      fetchContact(),
    ]);
  }

  // Piyasa kapitalizasyonunu gözlemleyen observable değişken.
  @observable
  MarketCapModel? marketCap;

  // Sinyal bilgisini gözlemleyen observable değişken.
  @observable
  SignalModel? signal;

  // İletişim bilgisini gözlemleyen observable değişken.
  @observable
  ContactModel? contact;

  // Piyasa kapitalizasyonu verisini çeken ve güncelleyen action metodu.
  @action
  Future<void> fetchMarketCap() async {
    final response = await _appService.fetchMarketCap();
    if (response != null) {
      marketCap = MarketCapModel.fromJson(response);
    }
  }

  // En son serbest sinyal verisini çeken ve güncelleyen action metodu.
  @action
  Future<void> fetchFreeSignalLast() async {
    final response = await _signalService.fetchFreeSignalLast();
    if (response != null) {
      signal = SignalModel.fromJson(response);
    }
  }

  // İletişim bilgisini çeken ve güncelleyen action metodu.
  @action
  Future<void> fetchContact() async {
    final response = await _appService.fetchContact();
    if (response != null) {
      contact = ContactModel.fromJson(response);
    }
  }
}
