import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../constants/app/app_constants.dart';
import '../network_manager.dart';

/// `UserService`, kullanıcı ile ilgili işlemleri yönetmek için istekleri gönderen
/// servis sınıfıdır.
class UserService {
  final NetworkManager _networkManager = NetworkManager.instance;
  final String _path = 'service.php';
  final String _serviceName = 'user';

  // Uygulama sabitlerinden alınan güvenlik anahtarını MD5 ile şifreler.
  final String _secureKey =
      md5.convert(utf8.encode(ApplicationConstants.secureKey)).toString();

  static UserService? _instance;

  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  static UserService get instance {
    _instance ??= UserService._init();
    return _instance!;
  }

  UserService._init();

  /// Mevcut kullanıcının verilerini çekmek için istek gönderir.
  Future<dynamic> fetchUser() async {
    String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    return _networkManager.dioPost(
      path: _path,
      data: {
        'secureKey': _secureKey,
        'serviceName': _serviceName,
        'methodName': 'fetchUser',
        'uid': currentUserUid,
      },
    );
  }

  /// Belirli bir UID'ye sahip kullanıcıyı silmek için istek gönderir.
  Future<dynamic> deleteUser(String uid) async {
    return _networkManager.dioPost(
      path: _path,
      data: {
        'secureKey': _secureKey,
        'serviceName': _serviceName,
        'methodName': 'deleteUser',
        'uid': uid,
      },
    );
  }

  /// Google ile oturum açma işlemi sonrasında, kullanıcı bilgilerini
  /// sunucuya kaydetmek için istek gönderir.
  Future<dynamic> googleSignIn() async {
    String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;
    return _networkManager.dioPost(
      path: _path,
      data: {
        'secureKey': _secureKey,
        'serviceName': _serviceName,
        'methodName': 'googleSignIn',
        'uid': currentUserUid,
        'email': currentUserEmail,
      },
    );
  }
}
