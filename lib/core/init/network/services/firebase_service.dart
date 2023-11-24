import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// `FirebaseService`, Firebase kimlik doğrulama işlemleri için servis sınıfıdır.
/// Google oturum açma ve oturumu kapatma işlevlerini sağlar.
class FirebaseService {
  // FirebaseAuth ve GoogleSignIn nesnelerinin örnekleri.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google hesabı ile oturum açma işlemini gerçekleştirir.
  Future<void> signInwithGoogle() async {
    try {
      // Kullanıcının Google ile oturum açmasını sağlar.
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      // Google oturum açma işleminden kimlik doğrulama bilgilerini alır.
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      // Google sağlayıcısı için kimlik bilgilerini oluşturur.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Firebase'e bu kimlik bilgileri ile oturum açma işlemini gerçekleştirir.
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Hata durumunda hata mesajını yazdırır ve hatayı yeniden fırlatır.
      if (kDebugMode) {
        debugPrint('Error : ${e.message}');
      }
      rethrow;
    }
  }

  /// Google hesabından ve Firebase oturumundan çıkış yapar.
  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut(); // Google oturumunu kapatır.
    await _auth.signOut(); // Firebase oturumunu kapatır.
  }
}
