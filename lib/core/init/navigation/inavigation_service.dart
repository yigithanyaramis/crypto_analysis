/// `INavigationService`, uygulama içi gezinme (navigasyon) işlemleri için kullanılacak 
/// yöntemlerin tanımlandığı soyut bir sınıftır. 
abstract class INavigationService {
  /// Verilen yol ile yeni bir sayfaya yönlendirme yapar.
  /// [path]: Yönlendirme yapılacak sayfanın yolu.
  /// [data]: Sayfaya iletilmek istenen veri (opsiyonel).
  Future<void> navigateToPage({required String path, Object? data});

  /// Verilen yol ile mevcut tüm sayfaları temizleyerek yeni bir sayfaya yönlendirme yapar.
  /// Böylece navigasyon yığını sıfırlanır ve yeni sayfa ana sayfa olur.
  /// [path]: Yönlendirme yapılacak sayfanın yolu.
  /// [data]: Sayfaya iletilmek istenen veri (opsiyonel).
  Future<void> navigateToPageClear({required String path, Object? data});

  /// Gezinme yığınının en üstündeki sayfayı kapatır.
  Future<void> navigateToPop();
}
