import 'package:mobx/mobx.dart';

import '../../core/init/network/services/iap_service.dart';

part 'vip_view_model.g.dart';

class VipViewModel = _VipViewModelBase with _$VipViewModel;

abstract class _VipViewModelBase with Store {
  late final IAPService _iapService;

  // _VipViewModelBase sınıfının kurucu metodu, _iapService özelliğini başlatır.
  _VipViewModelBase() : _iapService = IAPService.instance;

  // Satın alma işlemi eklemek için kullanılan bir asenkron fonksiyon.
  // İlgili ürün eklenirse true, eklenemezse false döner.
  @action
  Future<bool> addProduct({required String purchaseId}) async {
    // IAP servisinden gelen yanıtın durumunu kontrol eden yardımcı bir fonksiyon kullanılır.
    var response = await _iapService.addProduct(purchaseId: purchaseId);
    return _isStatusEqual(response, 1);
  }

  // Android IAP (In-App Purchase) doğrulama işlemi için kullanılan asenkron fonksiyon.
  // Doğrulama başarılı ise true, başarısız ise false döner.
  @action
  Future<bool> androidIapVerify({
    required String productId,
    required String purchaseToken,
  }) async {
    // IAP servisinden gelen yanıtın durumunu kontrol eden yardımcı bir fonksiyon kullanılır.
    var response = await _iapService.androidIapVerify(
      productId: productId,
      purchaseToken: purchaseToken,
    );
    return _isStatusEqual(response, 1);
  }

  // IAP logunu eklemek için kullanılan asenkron fonksiyon.
  // Log eklenirse true, eklenemezse false döner.
  @action
  Future<bool> addIAPLog({
    required String productId,
    required String purchaseToken,
    required String transactionId,
    required int control,
  }) async {
    // IAP servisinden gelen yanıtın durumunu kontrol eden yardımcı bir fonksiyon kullanılır.
    var response = await _iapService.addIAPLog(
      productId: productId,
      purchaseToken: purchaseToken,
      transactionId: transactionId,
      control: control,
    );
    return _isStatusEqual(response, 1);
  }

  // Servis yanıtının durumunu kontrol eden yardımcı bir fonksiyon.
  bool _isStatusEqual(Map<String, dynamic> response, int expectedStatus) {
    // Servis yanıtındaki durumu beklenen durumla karşılaştırır ve sonucu döner.
    return int.parse(response['status'].toString()) == expectedStatus;
  }
}
