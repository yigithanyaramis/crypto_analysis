import 'package:flutter/material.dart';

// Constants dosyalarınızın içe aktarılması.
import '../../constants/border/border_constants.dart';
import '../../constants/color/color_constants.dart';
import '../../constants/duration/duration_constants.dart';
import '../../constants/image/image_constants.dart';
import '../../constants/padding/padding_constants.dart';
import '../../constants/validator/validator_constants.dart';

final ColorConstants colorConstants = ColorConstants.instance;
final BorderConstants borderConstants = BorderConstants.instance;
final ValidatorConstants validatorConstants = ValidatorConstants.instance;
final ImageConstants imageConstants = ImageConstants.instance;
final PaddingConstants paddingConstants = PaddingConstants.instance;
final DurationConstants durationConstants = DurationConstants.instance;

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  // Tema verileri ve metin temaları hızlı erişim için özellikler olarak tanımlanır.
  ThemeData get themeData => Theme.of(context);
  TextTheme get textTheme => themeData.textTheme;

  // Ekran boyutları, tekrar tekrar MediaQuery çağırılmasını önlemek için üye değişkenler olarak tanımlanır.
  late final double screenHeight;
  late final double screenWidth;

  // didChangeDependencies, widget ağacındaki bağımlılıklar değiştiğinde çağrılan bir metodur.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // MediaQuery değerlerini burada bir kez hesaplayıp üye değişkenlere atıyoruz.
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  // Dinamik yükseklik hesaplama metodudur, ekran yüksekliğinin belirli bir oranını döndürür.
  double dynamicHeight(double value) => screenHeight * value;

  // Dinamik genişlik hesaplama metodudur, ekran genişliğinin belirli bir oranını döndürür.
  double dynamicWidth(double value) => screenWidth * value;
}
