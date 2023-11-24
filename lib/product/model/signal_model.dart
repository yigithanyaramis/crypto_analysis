import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/base/model/base_model.dart';

part 'signal_model.g.dart';

@JsonSerializable()
class SignalModel extends BaseModel<SignalModel> {
  // SignalModel sınıfının özelliklerinin tanımlanması
  final int id;
  final String imageUrl;
  final String coin;
  final String signalDate;
  final String enter;
  final String stop;
  final int capital;
  final String currentPrice;
  final String targetOne;
  final String targetTwo;
  final String targetThree;
  final String targetFour;
  final int targetStatus;

  // SignalModel sınıfının constructor metodu
  SignalModel({
    required this.id,
    required this.imageUrl,
    required this.coin,
    required this.signalDate,
    required this.enter,
    required this.stop,
    required this.capital,
    required this.currentPrice,
    required this.targetOne,
    required this.targetTwo,
    required this.targetThree,
    required this.targetFour,
    required this.targetStatus,
  });

  // JSON verilerini kullanarak bir SignalModel örneği oluşturan factory metodu
  factory SignalModel.fromJson(Map<String, dynamic> json) {
    return SignalModel(
      id: int.parse(json['id'].toString()),
      imageUrl: json['image_url'],
      coin: json['coin'],
      signalDate: json['signal_date'],
      enter: json['enter'],
      stop: json['stop'],
      capital: int.parse(json['capital'].toString()),
      currentPrice: json['current_price'],
      targetOne: json['target_one'],
      targetTwo: json['target_two'],
      targetThree: json['target_three'],
      targetFour: json['target_four'],
      targetStatus: json['target_status'],
    );
  }

  // SignalModel sınıfının JSON formatına çevrilmesini sağlayan metot
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'coin': coin,
      'signal_date': signalDate,
      'enter': enter,
      'stop': stop,
      'capital': capital,
      'current_price': currentPrice,
      'target_one': targetOne,
      'target_two': targetTwo,
      'target_three': targetThree,
      'target_four': targetFour,
      'target_status': targetStatus,
    };
  }

  // JSON verilerini kullanarak SignalModel örneği oluşturan metot
  @override
  SignalModel fromJson(Map<String, dynamic> json) {
    return SignalModel.fromJson(json);
  }
}
