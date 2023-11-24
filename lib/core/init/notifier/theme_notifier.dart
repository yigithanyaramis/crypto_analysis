import 'package:flutter/material.dart';

import '../../constants/enums/app_theme_enum.dart';
import '../theme/app_theme_dark.dart';
import '../theme/app_theme_light.dart';

/// `ThemeNotifier`, uygulamanın mevcut temasını yöneten ve tema değişikliklerini
/// dinleyicilere bildiren bir sınıftır.
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeDark.instance.theme;
  AppThemes _currentThemeEnum = AppThemes.DARK;

  ThemeData get currentTheme => _currentTheme;
  AppThemes get currentThemeEnum => _currentThemeEnum;

  /// Tema ve tema enum değerlerini ayarlayıp dinleyicileri bilgilendirir.
  void _setThemeAndEnum(ThemeData theme, AppThemes themeEnum) {
    _currentTheme = theme;
    _currentThemeEnum = themeEnum;
    notifyListeners();
  }

  /// Belirli bir tema enum değerine göre temayı değiştirir.
  void changeValue(AppThemes theme) {
    if (theme == AppThemes.LIGHT) {
      _setThemeAndEnum(AppThemeLight.instance.theme, AppThemes.LIGHT);
    } else {
      _setThemeAndEnum(AppThemeDark.instance.theme, AppThemes.DARK);
    }
  }

  /// Kullanıcının mevcut temasını tersine çevirir (koyu<->açık).
  void changeTheme() {
    if (_currentThemeEnum == AppThemes.LIGHT) {
      _setThemeAndEnum(AppThemeDark.instance.theme, AppThemes.DARK);
    } else {
      _setThemeAndEnum(AppThemeLight.instance.theme, AppThemes.LIGHT);
    }
  }
}
