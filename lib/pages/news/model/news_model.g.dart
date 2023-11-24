// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      id: json['id'] as int,
      photoUrl: json['photoUrl'] as String,
      title: json['title'] as String,
      titleEn: json['titleEn'] as String,
      description: json['description'] as String,
      descriptionEn: json['descriptionEn'] as String,
      isNews: json['isNews'] as bool,
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'id': instance.id,
      'photoUrl': instance.photoUrl,
      'title': instance.title,
      'titleEn': instance.titleEn,
      'description': instance.description,
      'descriptionEn': instance.descriptionEn,
      'isNews': instance.isNews,
    };
