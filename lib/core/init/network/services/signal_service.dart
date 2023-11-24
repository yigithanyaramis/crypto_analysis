import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../constants/app/app_constants.dart';
import '../network_manager.dart';

/// `SignalService`, finansal sinyal verileri gibi içerikleri çekmek için
/// isteklerini gönderen servis sınıfıdır.
class SignalService {
  final NetworkManager _networkManager = NetworkManager.instance;
  final String _path = 'service.php';
  final String _serviceName = 'signal';

  // Uygulama sabitlerinden alınan güvenlik anahtarını MD5 ile şifreler.
  final String _secureKey =
      md5.convert(utf8.encode(ApplicationConstants.secureKey)).toString();

  static SignalService? _instance;

  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  static SignalService get instance {
    _instance ??= SignalService._init();
    return _instance!;
  }

  SignalService._init();

  /// Ücretsiz sinyallerin tümünü çekmek için istek gönderir.
  Future<dynamic> fetchFreeSignalAll() async {
    return _networkManager.dioPost(
      path: _path,
      data: {
        'secureKey': _secureKey,
        'serviceName': _serviceName,
        'methodName': 'fetchFreeSignalAll',
      },
    );
  }

  /// VIP sinyallerin tümünü çekmek için istek gönderir.
  Future<dynamic> fetchVipSignalAll() async {
    return _networkManager.dioPost(
      path: _path,
      data: {
        'secureKey': _secureKey,
        'serviceName': _serviceName,
        'methodName': 'fetchVipSignalAll',
      },
    );
  }

  /// En son ücretsiz sinyali çekmek için istek gönderir.
  Future<dynamic> fetchFreeSignalLast() async {
    return _networkManager.dioPost(
      path: _path,
      data: {
        'secureKey': _secureKey,
        'serviceName': _serviceName,
        'methodName': 'fetchFreeSignalLast',
      },
    );
  }
}
