import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';
import '../../core/constants/navigation/navigation_constants.dart';
import '../../core/extension/string_extension.dart';
import '../../core/init/languages/locale_keys.g.dart';
import '../../core/init/navigation/navigation_service.dart';
import 'vip_view_model.dart';

class VipView extends StatefulWidget {
  const VipView({super.key});

  @override
  State<VipView> createState() => _VipViewState();
}

class _VipViewState extends BaseState<VipView> {
  late final VipViewModel _viewModel;
  StreamSubscription? _purchaseUpdatedSubscription;
  StreamSubscription? _purchaseErrorSubscription;
  StreamSubscription? _connectionSubscription;

  // VIP paketlerinin ürün ID'leri
  final List<String> _productLists = [
    for (var sub in [1, 3, 6, 12]) 'sub_month_$sub'
  ];

  // Alınan ürünlerin eşleştirilmiş oldukları harita
  Map<String, IAPItem> _itemsMap = {};

  @override
  void initState() {
    _initializeInAppPurchases();
    super.initState();
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    _purchaseUpdatedSubscription?.cancel();
    _purchaseErrorSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeInAppPurchases() async {
    await _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    await FlutterInappPurchase.instance.initialize();

    // Satın alma bağlantısı durumunu takip eden dinleyici
    _connectionSubscription = FlutterInappPurchase.connectionUpdated
        .listen((connected) => _printDebug('Bağlandı: $connected'));

    // Satın alma işlemi güncellemelerini dinleyen dinleyici
    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen(_handlePurchase);

    // Satın alma hatası durumunu takip eden dinleyici
    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError
        .listen((error) => _printDebug('Satın Alma Hatası: $error'));
  }

  // Satın alma işlemi tamamlandığında yapılacak işlemleri yöneten metod
  void _handlePurchase(PurchasedItem? productItem) async {
    _printDebug('Satın Alma Güncellendi: $productItem');

    try {
      // Satın alınan tüm ürünleri tüketme işlemi
      String msg = await FlutterInappPurchase.instance.consumeAll();
      _printDebug('consumeAllItems: $msg');
    } catch (err) {
      _printDebug('consumeAllItems Hatası: $err');
    }

    bool androidIapVerificationResult = false;

    if (Platform.isAndroid) {
      // Android'de satın alma doğrulama işlemi
      androidIapVerificationResult = await _viewModel.androidIapVerify(
        productId: productItem?.productId ?? '',
        purchaseToken: productItem?.purchaseToken ?? '',
      );
    }

    // Android'de başarılı doğrulama veya iOS'ta doğrulama yapılmıyorsa işlemleri gerçekleştir
    if (androidIapVerificationResult || !Platform.isAndroid) {
      await _viewModel.addProduct(purchaseId: productItem?.productId ?? '');
      await _viewModel.addIAPLog(
        productId: productItem?.productId ?? '',
        purchaseToken: productItem?.purchaseToken ?? '',
        transactionId: productItem?.transactionId ?? '',
        control: androidIapVerificationResult ? 1 : 0,
      );
      // Ana sayfaya yönlendirme
      NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.mainView);
    } else {
      await _viewModel.addIAPLog(
        productId: productItem?.productId ?? '',
        purchaseToken: productItem?.purchaseToken ?? '',
        transactionId: productItem?.transactionId ?? '',
        control: 0,
      );
      // Yasaklanmış sayfasına yönlendirme
      NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.banView);
    }
  }

  // VIP paketlerinin bilgilerini getiren metod
  Future<void> _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    _itemsMap = {
      for (var item in items)
        if (item.productId != null) item.productId!: item
    };
  }

  // VIP paketinin fiyat bilgisini getiren metod
  String _getPrice(String productId) =>
      _itemsMap[productId]?.introductoryPrice ?? '';

  @override
  Widget build(BuildContext context) {
    return BaseView<VipViewModel>(
      viewModel: VipViewModel(),
      onModelReady: (model) {
        _viewModel = model;
      },
      onPageBuilder: (context, value) => buildBody(),
    );
  }

  // Sayfa içeriğini oluşturan metod
  Widget buildBody() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text(LocaleKeys.vip_buy_vip.translate)),
      ),
      body: Padding(
        padding: paddingConstants.basePadding,
        child: SingleChildScrollView(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildVIPPackages(),
                    const SizedBox(height: 15),
                    Text(
                      LocaleKeys.vip_information.translate,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    Platform.isIOS
                        ? const SizedBox.shrink()
                        : Text(
                            LocaleKeys.vip_android_note.translate,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 16),
                            textAlign: TextAlign.justify,
                          )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: colorConstants.secondaryColor,
                  ),
                );
              }
            },
            future: _getProduct(),
          ),
        ),
      ),
    );
  }

  // VIP paketlerini oluşturan metod
  List<Widget> _buildVIPPackages() {
    return _productLists
        .map((productId) => _buildVIPPackage(productId))
        .toList();
  }

  // Tek bir VIP paketini oluşturan metod
  InkWell _buildVIPPackage(String productId) {
    return InkWell(
      onTap: () {
        final iItem = _itemsMap[productId];
        if (iItem != null) {
          // Satın alma isteği gönderme
          FlutterInappPurchase.instance.requestPurchase(iItem.productId!);
        }
      },
      child: Card(
        color: colorConstants.primaryColor,
        child: Padding(
          padding: paddingConstants.allLowPadding,
          child: ListTile(
            title: Text(
              '${int.parse(productId.split('_').last)} ${LocaleKeys.vip_monthly.translate}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Roboto'),
            ),
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: borderConstants.borderRadiusLowAll,
              ),
              child: const Center(
                child: Icon(
                  FontAwesomeIcons.crown,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            subtitle: Text(
              _getPrice(productId),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontFamily: 'Roboto'),
            ),
          ),
        ),
      ),
    );
  }

  // Hata ayıklama mesajlarını yazdıran metod
  void _printDebug(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
