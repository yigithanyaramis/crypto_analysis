import 'package:easy_localization/easy_localization.dart';

/// `String` sınıfına eklenen bir extension ile çeviri yapmayı kolaylaştıran bir yardımcı metod.
/// Bu extension sayesinde, herhangi bir String değeri doğrudan çevrilebilir hale gelir.
extension StringTranslationExtension on String {
  /// Mevcut String için çeviri yapar.
  /// `tr()` metodu, `easy_localization` paketi tarafından sağlanır ve
  /// çağrıldığında, mevcut locale göre çeviri döndürür.
  String get translate => this.tr();
}
