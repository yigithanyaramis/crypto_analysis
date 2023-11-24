// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signals_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignalsViewModel on _SignalsViewModelBase, Store {
  late final _$signalListAtom =
      Atom(name: '_SignalsViewModelBase.signalList', context: context);

  @override
  ObservableList<SignalModel> get signalList {
    _$signalListAtom.reportRead();
    return super.signalList;
  }

  @override
  set signalList(ObservableList<SignalModel> value) {
    _$signalListAtom.reportWrite(value, super.signalList, () {
      super.signalList = value;
    });
  }

  late final _$signalVipListAtom =
      Atom(name: '_SignalsViewModelBase.signalVipList', context: context);

  @override
  ObservableList<SignalModel> get signalVipList {
    _$signalVipListAtom.reportRead();
    return super.signalVipList;
  }

  @override
  set signalVipList(ObservableList<SignalModel> value) {
    _$signalVipListAtom.reportWrite(value, super.signalVipList, () {
      super.signalVipList = value;
    });
  }

  late final _$userAtom =
      Atom(name: '_SignalsViewModelBase.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$fetchFreeSignalAllAsyncAction =
      AsyncAction('_SignalsViewModelBase.fetchFreeSignalAll', context: context);

  @override
  Future<void> fetchFreeSignalAll() {
    return _$fetchFreeSignalAllAsyncAction
        .run(() => super.fetchFreeSignalAll());
  }

  late final _$fetchVipSignalAllAsyncAction =
      AsyncAction('_SignalsViewModelBase.fetchVipSignalAll', context: context);

  @override
  Future<void> fetchVipSignalAll() {
    return _$fetchVipSignalAllAsyncAction.run(() => super.fetchVipSignalAll());
  }

  late final _$fetchUserAsyncAction =
      AsyncAction('_SignalsViewModelBase.fetchUser', context: context);

  @override
  Future<void> fetchUser() {
    return _$fetchUserAsyncAction.run(() => super.fetchUser());
  }

  @override
  String toString() {
    return '''
signalList: ${signalList},
signalVipList: ${signalVipList},
user: ${user}
    ''';
  }
}
