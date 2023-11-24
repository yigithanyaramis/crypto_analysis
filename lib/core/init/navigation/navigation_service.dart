import 'package:flutter/material.dart';

import 'inavigation_service.dart';

/// Uygulama içi sayfa yönlendirmelerini yönetmek için kullanılan servis sınıfıdır.
/// [INavigationService] arayüzünü uygular ve gezinme işlemleri için gerekli yöntemleri sağlar.
class NavigationService implements INavigationService {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final NavigationService _instance = NavigationService._init();
  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static NavigationService get instance => _instance;

  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  NavigationService._init();

  // Navigator işlemleri için global bir anahtar sağlar.
  // Bu anahtar, uygulamanın navigasyon durumuna erişimde kullanılır.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// Verilen yola göre sayfa yönlendirmesi yapar.
  @override
  Future<void> navigateToPage({required String path, Object? data}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
  }

  /// Verilen yola göre sayfa yönlendirmesi yapar ve mevcut tüm sayfaları temizler.
  @override
  Future<void> navigateToPageClear({required String path, Object? data}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      path,
      (Route<dynamic> route) => false,
      arguments: data,
    );
  }

  /// Navigasyon yığınının en üstündeki sayfayı kapatır.
  @override
  Future<void> navigateToPop() async => navigatorKey.currentState!.pop(true);
}
