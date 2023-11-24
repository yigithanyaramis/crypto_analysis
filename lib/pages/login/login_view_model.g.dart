// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on _LoginViewModelBase, Store {
  late final _$checkTermOfUseAtom =
      Atom(name: '_LoginViewModelBase.checkTermOfUse', context: context);

  @override
  bool get checkTermOfUse {
    _$checkTermOfUseAtom.reportRead();
    return super.checkTermOfUse;
  }

  @override
  set checkTermOfUse(bool value) {
    _$checkTermOfUseAtom.reportWrite(value, super.checkTermOfUse, () {
      super.checkTermOfUse = value;
    });
  }

  late final _$contactAtom =
      Atom(name: '_LoginViewModelBase.contact', context: context);

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

  late final _$signInAsyncAction =
      AsyncAction('_LoginViewModelBase.signIn', context: context);

  @override
  Future<void> signIn() {
    return _$signInAsyncAction.run(() => super.signIn());
  }

  late final _$fetchContactAsyncAction =
      AsyncAction('_LoginViewModelBase.fetchContact', context: context);

  @override
  Future<void> fetchContact() {
    return _$fetchContactAsyncAction.run(() => super.fetchContact());
  }

  late final _$banCheckAsyncAction =
      AsyncAction('_LoginViewModelBase.banCheck', context: context);

  @override
  Future<bool> banCheck() {
    return _$banCheckAsyncAction.run(() => super.banCheck());
  }

  late final _$_LoginViewModelBaseActionController =
      ActionController(name: '_LoginViewModelBase', context: context);

  @override
  void changeCheckTermOfUse(bool value) {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.changeCheckTermOfUse');
    try {
      return super.changeCheckTermOfUse(value);
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
checkTermOfUse: ${checkTermOfUse},
contact: ${contact}
    ''';
  }
}
