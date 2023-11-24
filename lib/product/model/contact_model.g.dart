// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      telegram: json['telegram'] as String,
      email: json['email'] as String,
      privacyPolicy: json['privacyPolicy'] as String,
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'telegram': instance.telegram,
      'email': instance.email,
      'privacyPolicy': instance.privacyPolicy,
    };
