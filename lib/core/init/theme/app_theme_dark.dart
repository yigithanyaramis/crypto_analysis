import 'package:flutter/material.dart';

import '../../constants/color/color_constants.dart';
import 'app_theme.dart';

/// `AppThemeDark`, uygulamanın koyu temasını tanımlayan sınıftır.
/// `AppTheme` sınıfından türemiştir ve koyu tema için gerekli özelleştirmeleri içerir.
class AppThemeDark extends AppTheme {
  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  static final AppThemeDark _instance = AppThemeDark._init();
  static AppThemeDark get instance => _instance;

  // Özel constructor ile tema ayarlarını başlatır.
  AppThemeDark._init() : super(theme: initializeTheme());

  /// Koyu tema için gerekli temel ayarların yapıldığı metoddur.
  static ThemeData initializeTheme() {
    // Renk sabitlerine erişim için ColorConstants sınıfı örneği alınır.
    final ColorConstants colorConstants = ColorConstants.instance;

    // Tema ayarları yapılır ve özelleştirilmiş ThemeData nesnesi döndürülür.
    return ThemeData.dark().copyWith(
      // Temel yazı tipi olarak 'Roboto' kullanılır.
      textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Roboto'),
      primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(fontFamily: 'Roboto'),

      // Scaffold'un arka plan rengi olarak tanımlanan koyu renk kullanılır.
      scaffoldBackgroundColor: colorConstants.backgroundColor,

      // AppBar teması özelleştirilir.
      appBarTheme: const AppBarTheme(
        // AppBar içindeki ikonların rengi beyaz olarak ayarlanır.
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      // AppBar'ın arka plan rengi olarak tanımlanan koyu renk kullanılır.
      ).copyWith(
        backgroundColor: colorConstants.backgroundColor,
      ),
    );
  }
}
