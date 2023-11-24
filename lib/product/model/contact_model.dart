import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/base/model/base_model.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel extends BaseModel<ContactModel> {
  // Telegram hesabı, e-posta ve gizlilik politikası bilgilerini içeren sınıfın tanımlanması
  final String telegram;
  final String email;
  final String privacyPolicy;

  // Constructor metodu ile sınıfın örneklenmesi
  ContactModel({
    required this.telegram,
    required this.email,
    required this.privacyPolicy,
  });

  // JSON verilerini kullanarak bir ContactModel örneği oluşturan factory metodu
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
        telegram: json['telegram'],
        email: json['email'],
        privacyPolicy: json['privacy_policy']
    );
  }

  // Sınıfın JSON formatına çevrilmesini sağlayan metot
  @override
  Map<String, dynamic> toJson() {
    return {
      'telegram': telegram,
      'email': email,
      'privacy_policy': privacyPolicy
    };
  }

  // JSON verilerini kullanarak ContactModel örneği oluşturan metot
  @override
  ContactModel fromJson(Map<String, dynamic> json) {
    return ContactModel.fromJson(json);
  }
}
