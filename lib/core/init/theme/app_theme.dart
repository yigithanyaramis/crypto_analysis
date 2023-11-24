import 'package:flutter/material.dart';

/// `AppTheme`, uygulama için temel tema özelliklerini tanımlayan üst sınıftır.
/// Özelleştirilmiş tema sınıfları bu sınıftan türetilir.
class AppTheme {
  /// Tema ayarlarını içeren ThemeData nesnesi.
  final ThemeData theme;

  /// Tema sınıfının constructor'ıdır.
  /// [theme] parametresi ile özelleştirilmiş bir ThemeData nesnesi alır.
  AppTheme({required this.theme});
}
