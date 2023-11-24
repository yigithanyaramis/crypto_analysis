import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../constants/app/app_constants.dart';
import '../network_manager.dart';

/// `AppService`, uygulama genelinde kullanılacak API servis çağrılarını yönetir.
class AppService {
  final NetworkManager _networkManager = NetworkManager.instance;
  final String _path = 'service.php';
  final String _serviceName = 'app';

  // ApplicationConstants'dan alınan secureKey'i MD5 ile şifreler.
  final String _secureKey =
      md5.convert(utf8.encode(ApplicationConstants.secureKey)).toString();

  static AppService? _instance;

  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  static AppService get instance {
    _instance ??= AppService._init();
    return _instance!;
  }

  AppService._init();

  /// İletişim bilgilerini çeken API servis çağrısı.
  Future<dynamic> fetchContact() async {
    return _networkManager.dioPost(path: _path, data: {
      'secureKey': _secureKey,
      'serviceName': _serviceName,
      'methodName': 'fetchContact'
    });
  }

  /// Piyasa değerini çeken API servis çağrısı.
  Future<dynamic> fetchMarketCap() async {
    return _networkManager.dioPost(path: _path, data: {
      'secureKey': _secureKey,
      'serviceName': _serviceName,
      'methodName': 'fetchMarketCap'
    });
  }
}
