// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VipViewModel on _VipViewModelBase, Store {
  late final _$addProductAsyncAction =
      AsyncAction('_VipViewModelBase.addProduct', context: context);

  @override
  Future<bool> addProduct({required String purchaseId}) {
    return _$addProductAsyncAction
        .run(() => super.addProduct(purchaseId: purchaseId));
  }

  late final _$androidIapVerifyAsyncAction =
      AsyncAction('_VipViewModelBase.androidIapVerify', context: context);

  @override
  Future<bool> androidIapVerify(
      {required String productId, required String purchaseToken}) {
    return _$androidIapVerifyAsyncAction.run(() => super
        .androidIapVerify(productId: productId, purchaseToken: purchaseToken));
  }

  late final _$addIAPLogAsyncAction =
      AsyncAction('_VipViewModelBase.addIAPLog', context: context);

  @override
  Future<bool> addIAPLog(
      {required String productId,
      required String purchaseToken,
      required String transactionId,
      required int control}) {
    return _$addIAPLogAsyncAction.run(() => super.addIAPLog(
        productId: productId,
        purchaseToken: purchaseToken,
        transactionId: transactionId,
        control: control));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
