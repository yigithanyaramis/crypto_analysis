// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewsViewModel on _NewsViewModelBase, Store {
  late final _$newsListAtom =
      Atom(name: '_NewsViewModelBase.newsList', context: context);

  @override
  ObservableList<NewsModel> get newsList {
    _$newsListAtom.reportRead();
    return super.newsList;
  }

  @override
  set newsList(ObservableList<NewsModel> value) {
    _$newsListAtom.reportWrite(value, super.newsList, () {
      super.newsList = value;
    });
  }

  late final _$graphicsListAtom =
      Atom(name: '_NewsViewModelBase.graphicsList', context: context);

  @override
  ObservableList<NewsModel> get graphicsList {
    _$graphicsListAtom.reportRead();
    return super.graphicsList;
  }

  @override
  set graphicsList(ObservableList<NewsModel> value) {
    _$graphicsListAtom.reportWrite(value, super.graphicsList, () {
      super.graphicsList = value;
    });
  }

  late final _$fetchNewsAllAsyncAction =
      AsyncAction('_NewsViewModelBase.fetchNewsAll', context: context);

  @override
  Future<void> fetchNewsAll() {
    return _$fetchNewsAllAsyncAction.run(() => super.fetchNewsAll());
  }

  late final _$fetchGraphicsAllAsyncAction =
      AsyncAction('_NewsViewModelBase.fetchGraphicsAll', context: context);

  @override
  Future<void> fetchGraphicsAll() {
    return _$fetchGraphicsAllAsyncAction.run(() => super.fetchGraphicsAll());
  }

  @override
  String toString() {
    return '''
newsList: ${newsList},
graphicsList: ${graphicsList}
    ''';
  }
}
