// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$marketCapAtom =
      Atom(name: '_HomeViewModelBase.marketCap', context: context);

  @override
  MarketCapModel? get marketCap {
    _$marketCapAtom.reportRead();
    return super.marketCap;
  }

  @override
  set marketCap(MarketCapModel? value) {
    _$marketCapAtom.reportWrite(value, super.marketCap, () {
      super.marketCap = value;
    });
  }

  late final _$signalAtom =
      Atom(name: '_HomeViewModelBase.signal', context: context);

  @override
  SignalModel? get signal {
    _$signalAtom.reportRead();
    return super.signal;
  }

  @override
  set signal(SignalModel? value) {
    _$signalAtom.reportWrite(value, super.signal, () {
      super.signal = value;
    });
  }

  late final _$contactAtom =
      Atom(name: '_HomeViewModelBase.contact', context: context);

  @override
  ContactModel? get contact {
    _$contactAtom.reportRead();
    return super.contact;
  }

  @override
  set contact(ContactModel? value) {
    _$contactAtom.reportWrite(value, super.contact, () {
      super.contact = value;
    });
  }

  late final _$fetchInitialDataAsyncAction =
      AsyncAction('_HomeViewModelBase.fetchInitialData', context: context);

  @override
  Future<void> fetchInitialData() {
    return _$fetchInitialDataAsyncAction.run(() => super.fetchInitialData());
  }

  late final _$fetchMarketCapAsyncAction =
      AsyncAction('_HomeViewModelBase.fetchMarketCap', context: context);

  @override
  Future<void> fetchMarketCap() {
    return _$fetchMarketCapAsyncAction.run(() => super.fetchMarketCap());
  }

  late final _$fetchFreeSignalLastAsyncAction =
      AsyncAction('_HomeViewModelBase.fetchFreeSignalLast', context: context);

  @override
  Future<void> fetchFreeSignalLast() {
    return _$fetchFreeSignalLastAsyncAction
        .run(() => super.fetchFreeSignalLast());
  }

  late final _$fetchContactAsyncAction =
      AsyncAction('_HomeViewModelBase.fetchContact', context: context);

  @override
  Future<void> fetchContact() {
    return _$fetchContactAsyncAction.run(() => super.fetchContact());
  }

  @override
  String toString() {
    return '''
marketCap: ${marketCap},
signal: ${signal},
contact: ${contact}
    ''';
  }
}
