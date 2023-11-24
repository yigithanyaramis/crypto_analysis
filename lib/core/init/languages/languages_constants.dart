import 'package:flutter/material.dart';

/// `LanguagesConstants`, uygulama içinde kullanılacak diller ve yerelleştirme dosyaları
/// ile ilgili sabitleri tutan bir singleton sınıftır.
class LanguagesConstants {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final LanguagesConstants _instance = LanguagesConstants._init();
  
  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static LanguagesConstants get instance => _instance;

  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  LanguagesConstants._init();

  // Türkçe dilini tanımlayan Locale sabiti.
  final Locale trLocale = const Locale("tr", "TR");

  // İngilizce dilini tanımlayan Locale sabiti.
  final Locale enLocale = const Locale("en", "US");

  // Yerelleştirme dosyalarının bulunduğu yol.
  final String langPath = "assets/languages";

  // Uygulama tarafından desteklenen dillerin listesini döndüren getter.
  List<Locale> get supportedLocales => [trLocale, enLocale];
}
