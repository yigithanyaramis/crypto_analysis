import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../navigation/navigation_service.dart';
import 'theme_notifier.dart';

/// `ApplicationProvider`, uygulama genelinde erişilmesi gereken servis ve
/// durum yönetimi nesnelerini bir arada tutan sınıftır.
class ApplicationProvider {
  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  ApplicationProvider._init();

  static final ApplicationProvider _instance = ApplicationProvider._init();
  static ApplicationProvider get instance => _instance;

  // Uygulama içinde tekil olarak sağlanacak nesneler.
  List<SingleChildWidget> singleItems = [];

  // Uygulamanın farklı kısımlarında ihtiyaç duyulabilecek durum yönetimi nesneleri.
  List<SingleChildWidget> dependItems = [
    // Tema ayarlarını tutan ThemeNotifier nesnesini sağlar.
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(),
    ),
    // Uygulama içi gezinmeyi yöneten NavigationService nesnesini sağlar.
    Provider<NavigationService>.value(value: NavigationService.instance)
  ];

  // Kullanıcı arayüzünde değişikliklere neden olabilecek nesneler.
  List<SingleChildWidget> uiChangesItems = [];
}
