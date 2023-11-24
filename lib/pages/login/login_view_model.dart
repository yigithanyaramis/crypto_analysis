import 'package:mobx/mobx.dart';

import '../../core/init/network/services/app_service.dart';
import '../../core/init/network/services/user_service.dart';
import '../../product/model/contact_model.dart';

part 'login_view_model.g.dart';

// LoginViewModel sınıfı, _LoginViewModelBase sınıfından miras alınır ve Store ile işaretlenir
class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  late final UserService _userService;
  late final AppService _appService;

  // Constructor
  _LoginViewModelBase() {
    checkTermOfUse =
        false; // Kullanım Şartları kontrolü varsayılan olarak kapalıdır
    _appService = AppService.instance;
    _userService = UserService.instance;
    fetchContact(); // İletişim bilgilerini getir
  }

  @observable
  bool checkTermOfUse = false; // Kullanım Şartları kabul edildi mi?

  @observable
  ContactModel? contact; // İletişim Modeli

  // Kullanım Şartları kontrolünü değiştir
  @action
  void changeCheckTermOfUse(bool value) {
    checkTermOfUse = value;
  }

  // Google ile giriş yap
  @action
  Future<void> signIn() async {
    await _userService.googleSignIn();
  }

  // İletişim bilgilerini getir
  @action
  Future<void> fetchContact() async {
    var response = await _appService.fetchContact();
    contact = ContactModel.fromJson(response);
  }

  // Kullanıcının yasaklı olup olmadığını kontrol et
  @action
  Future<bool> banCheck() async {
    var response = await _userService.fetchUser();
    return int.parse(response['ban'].toString()) == 1 ? true : false;
  }
}
