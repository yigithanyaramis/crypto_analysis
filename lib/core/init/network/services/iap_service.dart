import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../constants/app/app_constants.dart';
import '../network_manager.dart';

/// `IAPService`, uygulama içi satın alma işlemleri için ağ istekleri gönderen servis sınıfıdır.
class IAPService {
  final NetworkManager _networkManager = NetworkManager.instance;
  final String _path = 'service.php';
  final String _serviceName = 'iap';

  // Uygulama sabitlerinden alınan güvenlik anahtarını MD5 ile şifreler.
  final String _secureKey =
      md5.convert(utf8.encode(ApplicationConstants.secureKey)).toString();

  static IAPService? _instance;

  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  static IAPService get instance {
    _instance ??= IAPService._init();
    return _instance!;
  }

  IAPService._init();

  /// Satın alınan ürünü eklemek için kullanılır.
  Future<dynamic> addProduct({required String purchaseId}) async {
    String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

    return _networkManager.dioPost(path: _path, data: {
      'secureKey': _secureKey,
      'serviceName': _serviceName,
      'methodName': 'addProduct',
      'uid': currentUserUid,
      'purchaseId': purchaseId
    });
  }

  /// Satın alma işleminin doğrulanması için kullanılır.
  Future<dynamic> androidIapVerify(
      {required String productId, required String purchaseToken}) async {
    return _networkManager.dioPost(path: _path, data: {
      'secureKey': _secureKey,
      'serviceName': _serviceName,
      'methodName': 'iapVerify',
      'packageName': ApplicationConstants.packageName,
      'productId': productId,
      'purchaseToken': purchaseToken
    });
  }

  /// Uygulama içi satın alma işleminin log'unu eklemek için kullanılır.
  Future addIAPLog(
      {required String productId,
      required String purchaseToken,
      required String transactionId,
      required int control}) async {
    String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    return _networkManager.dioPost(path: _path, data: {
      'secureKey': _secureKey,
      'serviceName': _serviceName,
      'methodName': 'addIAPLog',
      'productId': productId,
      'purchaseToken': purchaseToken,
      'transactionId': transactionId,
      'uid': currentUserUid,
      'control': control
    });
  }
}
