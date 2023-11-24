import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../constants/app/app_constants.dart';
import '../network_manager.dart';

/// `NewsService`, haber ve grafik verileri gibi içerikleri çekmek için
/// istekleri gönderen servis sınıfıdır.
class NewsService {
  final NetworkManager _networkManager = NetworkManager.instance;
  final String _path = 'service.php';
  final String _serviceName = 'news';

  // Uygulama sabitlerinden alınan güvenlik anahtarını MD5 ile şifreler.
  final String _secureKey =
      md5.convert(utf8.encode(ApplicationConstants.secureKey)).toString();

  static NewsService? _instance;

  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  static NewsService get instance {
    _instance ??= NewsService._init();
    return _instance!;
  }

  NewsService._init();

  /// Tüm haber verilerini çekmek için istek gönderir.
  Future<dynamic> fetchNewsAll() async {
    return _networkManager.dioPost(
      path: _path,
      data: {
        'secureKey': _secureKey,
        'serviceName': _serviceName,
        'methodName': 'fetchNewsAll',
      },
    );
  }

  /// Tüm grafik verilerini çekmek için istek gönderir.
  Future<dynamic> fetchGraphicsAll() async {
    return _networkManager.dioPost(
      path: _path,
      data: {
        'secureKey': _secureKey,
        'serviceName': _serviceName,
        'methodName': 'fetchGraphicsAll',
      },
    );
  }
}
