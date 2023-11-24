import '../../extension/string_extension.dart';
import '../../init/languages/locale_keys.g.dart';

// Validasyon için temel uzunluk sabitleri.
const int _validatorMinLength = 3;
const int _passwordMinLength = 3;
const int _passwordMaxLength = 32;

/// `ValidatorConstants`, form validasyonları için kullanılacak sabit ve 
/// yardımcı fonksiyonları içeren bir singleton sınıftır.
class ValidatorConstants {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final ValidatorConstants _instance = ValidatorConstants._init();
  
  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static ValidatorConstants get instance => _instance;

  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  ValidatorConstants._init();

  // E-posta için RegExp validasyon deseni.
  final RegExp _emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  /// Genel bir metin alanı validatörü.
  /// Eğer verilen değer belirlenen uzunluktan kısa ise hata mesajı döner.
  String? validator(String? value, {String? message, int? len}) {
    message ??= LocaleKeys.base_validation_message.translate;
    len ??= _validatorMinLength;
    if (value!.length < len) {
      return message;
    }
    return null;
  }

  /// Şifre için özel validatör.
  /// Verilen şifre değeri min ve max uzunluk aralığı dışında ise hata mesajı döner.
  String? passwordValidator(String? value,
      {String? message, int? len, int? maxLen}) {
    message ??= LocaleKeys.base_password_validation_message.translate;
    len ??= _passwordMinLength;
    maxLen ??= _passwordMaxLength;
    if (value!.length > maxLen || value.length < len) {
      return message;
    }
    return null;
  }

  /// E-posta validatörü.
  /// E-posta RegExp desenine uymayan değerler için hata mesajı döner.
  String? emailValidator(String? value) {
    if (!_emailRegex.hasMatch(value!)) {
      return LocaleKeys.base_email_validation_message.translate;
    }
    return null;
  }
}
