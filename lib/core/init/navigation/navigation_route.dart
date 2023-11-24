import 'package:flutter/material.dart';

import '../../../pages/login/login_view.dart';
import '../../../pages/main/main_view.dart';
import '../../../pages/news/model/news_model.dart';
import '../../../pages/news/news_detail/news_detail_view.dart';
import '../../../pages/profile/profile_view.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../extension/string_extension.dart';
import '../languages/locale_keys.g.dart';

/// Uygulama içi gezinme yollarını ve sayfa yönlendirmelerini yöneten sınıf.
class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  /// Gezinme yollarına göre sayfa oluşturan metod.
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.mainView:
        return _normalNavigate(MainView(), settings: settings);
      case NavigationConstants.loginView:
        return _normalNavigate(const LoginView(), settings: settings);
      case NavigationConstants.profileView:
        return _normalNavigate(const ProfileView(), settings: settings);
      case NavigationConstants.newsDetailView:
        final news = settings.arguments as NewsModel;
        return _normalNavigate(NewsDetailView(news: news), settings: settings);
      case NavigationConstants.banView:
        return _bannedUserRoute();
      default:
        return _notFoundRoute();
    }
  }

  /// Normal gezinme işlemi için kullanılan özel bir yönlendirme metodudur.
  MaterialPageRoute _normalNavigate(Widget widget, {RouteSettings? settings}) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }

  /// Sayfa bulunamadığında gösterilen yönlendirme metodudur.
  MaterialPageRoute _notFoundRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(
            LocaleKeys.base_not_found.translate,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  /// Erişimi yasaklanmış kullanıcılar için kullanılan yönlendirme metodudur.
  MaterialPageRoute _bannedUserRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(
            LocaleKeys.base_banned.translate,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
