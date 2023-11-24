import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends StatefulWidget {
  const BaseView({
    super.key,
    required this.viewModel, 
    required this.onPageBuilder, // State hazır olduğunda sayfa oluşturulacak fonksiyon.
    required this.onModelReady, // Store hazır olduğunda çalıştırılacak fonksiyon.
    this.onDispose, // Widget dispose olduğunda isteğe bağlı olarak çalıştırılacak fonksiyon.
  });

  /// Widget ağacının bu sayfanın nasıl oluşturulacağını belirleyen fonksiyonu.
  /// Yüksek seviye bir fonksiyon olarak, context ve viewModel üzerinden widget oluşturur.
  final Widget Function(BuildContext context, T value) onPageBuilder;

  /// ViewModel, bu widget'ın state yönetimini sağlayacak MobX Store'udur.
  final T viewModel;

  /// `onModelReady` fonksiyonu, viewModel hazır olduğunda çalıştırılacak.
  final void Function(T model) onModelReady;

  /// `onDispose` fonksiyonu, widget dispose olduğunda çalıştırılacak olan
  /// isteğe bağlı bir callback'tir.
  final VoidCallback? onDispose;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

/// `_BaseViewState` [BaseView] için state yönetimini sağlayan sınıftır.
class _BaseViewState<T extends Store> extends State<BaseView<T>> {
  /// Model, viewModel'in geçici bir referansı olarak kullanılacaktır.
  late T model;

  @override
  void initState() {
    super.initState();
    model = widget.viewModel; // ViewModel'i model değişkenine ata.
    widget.onModelReady(model); // Model hazır olduğunda ilgili fonksiyonu çalıştır.
  }

  @override
  void dispose() {
    widget.onDispose?.call(); // Eğer varsa, dispose callback'ini çağır.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Context ve model kullanarak sayfa yapısını oluştur.
    return widget.onPageBuilder(context, model);
  }
}
