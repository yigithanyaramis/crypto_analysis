// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_cap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketCapModel _$MarketCapModelFromJson(Map<String, dynamic> json) =>
    MarketCapModel(
      price: json['price'] as String,
      change24H: json['change24H'] as String,
      marketCap: json['marketCap'] as String,
      totalVolume: json['totalVolume'] as String,
      fearGreed: json['fearGreed'] as int,
    );

Map<String, dynamic> _$MarketCapModelToJson(MarketCapModel instance) =>
    <String, dynamic>{
      'price': instance.price,
      'change24H': instance.change24H,
      'marketCap': instance.marketCap,
      'totalVolume': instance.totalVolume,
      'fearGreed': instance.fearGreed,
    };
