import 'package:flutter/material.dart';

// Kenarlık yarıçapları için sabit değerler.
const double _radiusLowValue = 5.0;
const double _radiusMediumValue = 15.0;
const double _radiusHighValue = 25.0;

/// `BorderConstants` uygulama genelinde kullanılacak kenarlık yarıçaplarını
/// tanımlayan bir singleton sınıftır.
class BorderConstants {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final BorderConstants _instance = BorderConstants._init();

  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static BorderConstants get instance => _instance;

  // Constructor'ın `_init` ile özel bir ismi vardır. 
  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  BorderConstants._init();

  // Düşük yarıçap değeri için getter.
  Radius get radiusLow => const Radius.circular(_radiusLowValue);
  
  // Orta yarıçap değeri için getter.
  Radius get radiusMedium => const Radius.circular(_radiusMediumValue);
  
  // Yüksek yarıçap değeri için getter.
  Radius get radiusHigh => const Radius.circular(_radiusHighValue);

  // Her bir yarıçap değeri için tüm kenarları kapsayacak şekilde
  // `BorderRadius` değerlerini döndüren getter'lar.
  BorderRadius get borderRadiusLowAll => BorderRadius.all(radiusLow);
  BorderRadius get borderRadiusMediumAll => BorderRadius.all(radiusMedium);
  BorderRadius get borderRadiusHighAll => BorderRadius.all(radiusHigh);
}
