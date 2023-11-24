import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'core/base/state/base_state.dart';
import 'core/constants/app/app_constants.dart';
import 'core/init/languages/languages_constants.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/provider_list.dart';
import 'core/init/notifier/theme_notifier.dart';
import 'pages/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Asenkron başlangıç işlevleri

  //EasyLocalization paketi ile dil desteğini başlatır
  await EasyLocalization.ensureInitialized();

  // Firebase hizmetlerini başlatır.
  await Firebase.initializeApp();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  final initFuture = Initialization.init();
  final NotificationService notificationService = NotificationService();

  // Uygulama widget ağacını oluşturulması ve çalıştırılması.
  runApp(
    MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: EasyLocalization(
        supportedLocales: LanguagesConstants.instance.supportedLocales,
        path: LanguagesConstants.instance.langPath,
        fallbackLocale: LanguagesConstants.instance.enLocale,
        child: MainApp(
            initFuture: initFuture, notificationService: notificationService),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  final Future<void> initFuture;
  final NotificationService notificationService;

  // MainApp widget'ının kurucu fonksiyonu, başlangıç işlemlerini bekleyen gelecek ve bildirim servisileri
  const MainApp({
    super.key,
    required this.initFuture,
    required this.notificationService,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends BaseState<MainApp> {
  late final FirebaseAnalytics analytics;

  @override
  void initState() {
    super.initState();
    analytics = FirebaseAnalytics.instance;

    // Başlangıç işlemleri tamamlandığında ek işlemler.
    widget.initFuture.then((_) {
      if (kDebugMode) {
        debugPrint("Başlatma Tamamlandı");
      }
      // OneSignal yapılandırması
      OneSignalConfigurator.configure();
    });
  }

  // Uygulamanın görsel yapısı
  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService.instance;

    return MaterialApp(
      theme: context.watch<ThemeNotifier>().currentTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: navigationService.navigatorKey,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      // Başlangıç işlemleri tamamlandıktan sonra LoginView sayfasını gösterilir, aksi halde CircularProgressIndicator gösterilir.
      home: FutureBuilder(
        future: widget.initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginView();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imageConstants.splashLogo),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
              ],
            );
          }
        },
      ),
    );
  }
}

// Uygulamanın başlangıç işlemleri
class Initialization {
  // Iap ve bildirim hizmetlerini başlatır.
  static Future<void> init() async {
    await FlutterInappPurchase.instance.initialize();
    await NotificationService().initialize();
  }
}

// OneSignal bildirim hizmetinin yapılandırmasını yönetir.
class OneSignalConfigurator {
  static void configure() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(ApplicationConstants.oneSignalId);
    OneSignal.Notifications.requestPermission(true);
  }
}

// Bildirim hizmetlerini başlatmak için kullanılır.
class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Bildirim kanallarını ve izinleri ayarlar.
  Future<void> initialize() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // iOS için özel bildirim izinleri ve abonelikleri.
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      await FirebaseMessaging.instance.subscribeToTopic('ios');
    } else {
      // Android için abonelik.
      await FirebaseMessaging.instance.subscribeToTopic('android');
    }

    // Herkes için genel abonelik.
    await FirebaseMessaging.instance.subscribeToTopic('all');
  }
}
