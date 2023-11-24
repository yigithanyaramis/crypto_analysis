import 'package:flutter/material.dart';

// Padding değerleri için temel sabitler.
const double _basePaddingValue = 16.0;
const double _lowPaddingValue = 5.0;
const double _mediumPaddingValue = 10.0;
const double _highPaddingValue = 20.0;

/// `PaddingConstants`, uygulama genelinde kullanılacak padding değerlerini
/// tanımlayan bir singleton sınıftır.
class PaddingConstants {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final PaddingConstants _instance = PaddingConstants._init();
  
  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static PaddingConstants get instance => _instance;

  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  PaddingConstants._init();

  // Temel padding değeri.
  EdgeInsets get basePadding => const EdgeInsets.all(_basePaddingValue);

  // Her yöne düşük padding değeri.
  EdgeInsets get allLowPadding => const EdgeInsets.all(_lowPaddingValue);

  // Her yöne orta padding değeri.
  EdgeInsets get allMedPadding => const EdgeInsets.all(_mediumPaddingValue);

  // Her yöne yüksek padding değeri.
  EdgeInsets get allHighPadding => const EdgeInsets.all(_highPaddingValue);

  // Yalnızca dikey yönde orta padding değeri.
  EdgeInsets get verticalMedPadding => const EdgeInsets.symmetric(vertical: _mediumPaddingValue);

  // Yalnızca üst kısıma düşük padding değeri.
  EdgeInsets get topLowPadding => const EdgeInsets.only(top: _lowPaddingValue);

  // Yalnızca üst kısıma orta padding değeri.
  EdgeInsets get topMedPadding => const EdgeInsets.only(top: _mediumPaddingValue);

  // Yalnızca üst kısıma yüksek padding değeri.
  EdgeInsets get topHighPadding => const EdgeInsets.only(top: _highPaddingValue);

  // Yalnızca alt kısıma düşük padding değeri.
  EdgeInsets get bottomLowPadding => const EdgeInsets.only(bottom: _lowPaddingValue);

  // Yalnızca alt kısıma orta padding değeri.
  EdgeInsets get bottomMedPadding => const EdgeInsets.only(bottom: _mediumPaddingValue);

  // Yalnızca alt kısıma yüksek padding değeri.
  EdgeInsets get bottomHighPadding => const EdgeInsets.only(bottom: _highPaddingValue);
}
