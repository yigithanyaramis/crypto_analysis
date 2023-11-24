// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  late final _$userAtom =
      Atom(name: '_ProfileViewModelBase.user', context: context);

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

  late final _$fetchUserAsyncAction =
      AsyncAction('_ProfileViewModelBase.fetchUser', context: context);

  @override
  Future<void> fetchUser() {
    return _$fetchUserAsyncAction.run(() => super.fetchUser());
  }

  late final _$deleteUserAsyncAction =
      AsyncAction('_ProfileViewModelBase.deleteUser', context: context);

  @override
  Future<void> deleteUser(String uid) {
    return _$deleteUserAsyncAction.run(() => super.deleteUser(uid));
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
