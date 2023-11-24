import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/base/model/base_model.dart';

part 'market_cap_model.g.dart';

@JsonSerializable()
class MarketCapModel extends BaseModel<MarketCapModel> {
  final String price; // Fiyat
  final String change24H; // 24 Saatlik Değişim
  final String marketCap; // Piyasa Değeri
  final String totalVolume; // Toplam Hacim
  final int fearGreed; // Korku / Hırs

  MarketCapModel({
    required this.price,
    required this.change24H,
    required this.marketCap,
    required this.totalVolume,
    required this.fearGreed,
  });

// JSON verisini nesneye dönüştüren factory method
  factory MarketCapModel.fromJson(Map<String, dynamic> json) {
    return MarketCapModel(
      price: json['price'] ??
          '', // JSON'da fiyat bilgisi olmayabilir, varsayılan değer atanır
      change24H: json['change_24h'] ?? '', // 24 saatlik değişim bilgisi
      marketCap: json['market_cap'] ?? '', // Piyasa değeri bilgisi
      totalVolume: json['total_volume'] ?? '', // Toplam hacim bilgisi
      fearGreed:
          int.parse(json['fear_greed'].toString()), // Korku / Hırs bilgisi
    );
  }

  // Nesneyi JSON'a dönüştüren metod
  @override
  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'change_24h': change24H,
      'market_cap': marketCap,
      'total_volume': totalVolume,
      'fear_greed': fearGreed
    };
  }

  // JSON verisini nesneye dönüştüren metod
  @override
  MarketCapModel fromJson(Map<String, dynamic> json) {
    return MarketCapModel.fromJson(json);
  }
}
