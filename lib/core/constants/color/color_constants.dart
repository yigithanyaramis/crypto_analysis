import 'package:flutter/material.dart';

/// `ColorConstants` uygulama genelinde kullanılacak renk sabitlerini
/// tanımlayan bir singleton sınıftır.
class ColorConstants {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final ColorConstants _instance = ColorConstants._init();
  
  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static ColorConstants get instance => _instance;

  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  ColorConstants._init();

  // Uygulamanın birincil rengini tanımlayan getter.
  Color get primaryColor => const Color.fromARGB(255, 31, 36, 46);
  
  // Uygulamanın ikincil rengini tanımlayan getter.
  Color get secondaryColor => const Color.fromARGB(255, 66, 142, 255);
  
  // Uygulamanın arka plan rengini tanımlayan getter.
  Color get backgroundColor => const Color.fromARGB(255, 27, 27, 27);
}
