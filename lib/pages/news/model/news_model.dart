import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/base/model/base_model.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel extends BaseModel<NewsModel> {
  final int id;
  final String photoUrl; // Fotoğraf URL
  final String title; // Başlık
  final String titleEn; // İngilizce Başlık
  final String description; // Açıklama 
  final String descriptionEn; // İngilizce Açıklama
  final bool isNews; // True ise Haber değilse Grafik

  NewsModel({
    required this.id,
    required this.photoUrl,
    required this.title,
    required this.titleEn,
    required this.description,
    required this.descriptionEn,
    required this.isNews,
  });

  // JSON verisini nesneye dönüştüren factory method
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: int.parse(json['id'].toString()),
      photoUrl: json['photo_url'],  // Fotoğraf URL
      title: json['title'],  // Başlık
      titleEn: json['title_en'], // İngilizce Başlık
      description: json['description'], // Açıklama 
      descriptionEn: json['description_en'], // İngilizce Açıklama
      isNews: int.parse(json['is_news'].toString()) == 1 ? true : false, // True ise Haber değilse Grafik
    );
  }

  // Nesneyi JSON'a dönüştüren metod
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo_url': photoUrl,
      'title': title,
      'title_en': titleEn,
      'description': description,
      'description_en': descriptionEn,
      'is_news': isNews ? 1 : 0
    };
  }

  // JSON verisini nesneye dönüştüren metod
  @override
  NewsModel fromJson(Map<String, dynamic> json) {
    return NewsModel.fromJson(json);
  }
}
