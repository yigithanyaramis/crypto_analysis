import 'package:flutter/material.dart';

import '../../constants/color/color_constants.dart';
import 'app_theme.dart';

/// `AppThemeLight`, uygulamanın açık temasını tanımlayan sınıftır.
/// `AppTheme` sınıfından türemiştir ve açık tema için gerekli özelleştirmeleri içerir.
class AppThemeLight extends AppTheme {
  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  static final AppThemeLight _instance = AppThemeLight._init();
  static AppThemeLight get instance => _instance;

  // Özel constructor ile tema ayarlarını başlatır.
  AppThemeLight._init() : super(theme: initializeTheme());

  /// Açık tema için gerekli temel ayarların yapıldığı metoddur.
  static ThemeData initializeTheme() {
    // Renk sabitlerine erişim için ColorConstants sınıfı örneği alınır.
    final ColorConstants colorConstants = ColorConstants.instance;

    // Tema ayarları yapılır ve özelleştirilmiş ThemeData nesnesi döndürülür.
    return ThemeData.light().copyWith(
      // Temel yazı tipi olarak 'Roboto' kullanılır.
      textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Roboto'),
      primaryTextTheme: ThemeData.light().primaryTextTheme.apply(fontFamily: 'Roboto'),

      // Scaffold'un arka plan rengi olarak tanımlanan açık renk kullanılır.
      scaffoldBackgroundColor: colorConstants.backgroundColor,

      // AppBar teması özelleştirilir.
      appBarTheme: const AppBarTheme(
        // AppBar içindeki ikonların rengi beyaz olarak ayarlanır.
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      // AppBar'ın arka plan rengi olarak tanımlanan açık renk kullanılır.
      ).copyWith(
        backgroundColor: colorConstants.backgroundColor,
      ),
    );
  }
}
