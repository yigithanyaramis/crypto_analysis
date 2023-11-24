// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalModel _$SignalModelFromJson(Map<String, dynamic> json) => SignalModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      coin: json['coin'] as String,
      signalDate: json['signalDate'] as String,
      enter: json['enter'] as String,
      stop: json['stop'] as String,
      capital: json['capital'] as int,
      currentPrice: json['currentPrice'] as String,
      targetOne: json['targetOne'] as String,
      targetTwo: json['targetTwo'] as String,
      targetThree: json['targetThree'] as String,
      targetFour: json['targetFour'] as String,
      targetStatus: json['targetStatus'] as int,
    );

Map<String, dynamic> _$SignalModelToJson(SignalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'coin': instance.coin,
      'signalDate': instance.signalDate,
      'enter': instance.enter,
      'stop': instance.stop,
      'capital': instance.capital,
      'currentPrice': instance.currentPrice,
      'targetOne': instance.targetOne,
      'targetTwo': instance.targetTwo,
      'targetThree': instance.targetThree,
      'targetFour': instance.targetFour,
      'targetStatus': instance.targetStatus,
    };
