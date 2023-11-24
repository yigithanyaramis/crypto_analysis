// Animasyonlar ve diğer zaman gecikmeleri için süre sabitleri.
const int _millisecondsLow = 100;
const int _millisecondsMedium = 250;
const int _secondsHigh = 1;

/// `DurationConstants`, uygulama genelinde kullanılacak zaman süreleri için
/// tanımlanan bir singleton sınıftır.
class DurationConstants {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final DurationConstants _instance = DurationConstants._init();
  
  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static DurationConstants get instance => _instance;

  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  DurationConstants._init();

  // Kısa süreli işlemler için tanımlanan zaman süresi getter'ı.
  Duration get lowDuration => const Duration(milliseconds: _millisecondsLow);
  
  // Orta süreli işlemler için tanımlanan zaman süresi getter'ı.
  Duration get mediumDuration => const Duration(milliseconds: _millisecondsMedium);
  
  // Uzun süreli işlemler için tanımlanan zaman süresi getter'ı.
  // Burada süre saniye cinsinden tanımlanmıştır.
  Duration get highDuration => const Duration(seconds: _secondsHigh);
}
