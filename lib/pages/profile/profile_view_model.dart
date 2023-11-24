import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../core/init/network/services/user_service.dart';
import '../../product/model/user_model.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store {
  late final UserService _userService;

  // UserService'i başlatıcı metod içinde başlatın
  _ProfileViewModelBase() {
    _userService = UserService.instance;
    fetchUser();
  }

  // Kullanıcı modelini tutacak olan observable alan
  @observable
  UserModel? user;

  // Kullanıcıyı getiren metot
  @action
  Future<void> fetchUser() async {
    try {
      var response = await _userService.fetchUser();

      // JSON yanıtını UserModel'e dönüştürün
      user = UserModel.fromJson(response);
    } catch (e) {
      // Hata durumlarını burada işleyin
      if (kDebugMode) {
        debugPrint('Kullanıcı getirilirken hata oluştu: $e');
      }
    }
  }

  // Kullanıcıyı silen metot
  @action
  Future<void> deleteUser(String uid) async {
    try {
      await _userService.deleteUser(uid);
    } catch (e) {
      // Hata durumlarını burada işleyin
      if (kDebugMode) {
        debugPrint('Kullanıcı silinirken hata oluştu: $e');
      }
    }
  }
}
