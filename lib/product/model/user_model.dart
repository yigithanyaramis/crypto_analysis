import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/base/model/base_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseModel<UserModel> {
  // UserModel sınıfının özelliklerinin tanımlanması
  final int id;
  final String uid;
  final String email;
  final String premiumFinishDate;

  // UserModel sınıfının constructor metodu
  UserModel({
    required this.id,
    required this.uid,
    required this.email,
    required this.premiumFinishDate,
  });

  // JSON verilerini kullanarak bir UserModel örneği oluşturan factory metodu
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id'].toString()),
      uid: json['uid'],
      email: json['email'],
      premiumFinishDate: json['premium_finish_date'],
    );
  }

  // UserModel sınıfının JSON formatına çevrilmesini sağlayan metot
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'email': email,
      'premium_finish_date': premiumFinishDate,
    };
  }

  // JSON verilerini kullanarak UserModel örneği oluşturan metot
  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
