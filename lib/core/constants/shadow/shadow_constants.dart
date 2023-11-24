import 'package:flutter/material.dart';

// Gölge efektleri için sabit değerler.
const double _opacityLevel = 0.9;
const double _blurEffectRadius = 10.0;
const double _horizontalOffset = 1.0;
const double _verticalOffset = 1.0;
const double _spreadEffectRadius = 0.5;

/// `ShadowConstants`, uygulama genelinde kullanılacak gölge değerlerini
/// tanımlayan bir singleton sınıftır.
class ShadowConstants {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final ShadowConstants _instance = ShadowConstants._init();
  
  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static ShadowConstants get instance => _instance;

  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  ShadowConstants._init();

  // Uygulama genelinde kullanılacak temel gölge stilini tanımlar.
  final List<BoxShadow> baseShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(_opacityLevel), // Gölge rengi ve saydamlığı.
      blurRadius: _blurEffectRadius, // Gölgenin bulanıklık yarıçapı.
      offset: const Offset(_horizontalOffset, _verticalOffset), // Gölgenin yatay ve dikey pozisyonu.
      spreadRadius: _spreadEffectRadius, // Gölgenin yayılma yarıçapı.
    ),
  ];
}
