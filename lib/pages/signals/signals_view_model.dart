import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../core/init/network/services/signal_service.dart';
import '../../core/init/network/services/user_service.dart';
import '../../product/model/signal_model.dart';
import '../../product/model/user_model.dart';

part 'signals_view_model.g.dart';

class SignalsViewModel = _SignalsViewModelBase with _$SignalsViewModel;

abstract class _SignalsViewModelBase with Store {
  late final SignalService _signalService;
  late final UserService _userService;

  _SignalsViewModelBase() {
    _userService = UserService.instance;
    _signalService = SignalService.instance;
    // İlk başta free ve vip sinyalleri çek
    fetchFreeSignalAll();
    fetchVipSignalAll();
    // Kullanıcı bilgilerini çek
    fetchUser();
  }

  // Observer için kullanılacak sinyaller
  @observable
  ObservableList<SignalModel> signalList = ObservableList<SignalModel>();

  // Free sinyalleri çek
  @action
  Future<void> fetchFreeSignalAll() async {
    var response = await _signalService.fetchFreeSignalAll();

    if (response is List) {
      // Eğer cevap bir liste ise, sinyal listesini temizle ve yeni sinyalleri ekle
      signalList.clear();
      signalList.addAll(response.map((match) => SignalModel.fromJson(match)));
    } else if (response is Map && response.containsKey('error')) {
      // Hata durumunda hata mesajını yazdır
      if (kDebugMode) {
        debugPrint(
            'Free sinyaller getirilirken hata oluştu: ${response['error']}');
      }
    }
  }

  // Observer için kullanılacak VIP sinyaller
  @observable
  ObservableList<SignalModel> signalVipList = ObservableList<SignalModel>();

  // VIP sinyallerini çek
  @action
  Future<void> fetchVipSignalAll() async {
    var response = await _signalService.fetchVipSignalAll();

    if (response is List) {
      // Eğer cevap bir liste ise, VIP sinyal listesini temizle ve yeni sinyalleri ekle
      signalVipList.clear();
      signalVipList
          .addAll(response.map((match) => SignalModel.fromJson(match)));
    } else if (response is Map && response.containsKey('error')) {
      // Hata durumunda hata mesajını yazdır
      if (kDebugMode) {
        debugPrint(
            'VIP sinyaller getirilirken hata oluştu: ${response['error']}');
      }
    }
  }

  // Observer için kullanılacak kullanıcı modeli
  @observable
  UserModel? user;

  // Kullanıcı bilgilerini çekme
  @action
  Future<void> fetchUser() async {
    var response = await _userService.fetchUser();

    user = UserModel.fromJson(response);
  }
}
