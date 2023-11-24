/// `ImageConstants`, uygulama içerisinde kullanılacak resim dosya yollarını
/// yönetmek için tasarlanmış bir singleton sınıftır.
class ImageConstants {
  // Sınıfın tek bir örneğini oluşturmak için özel bir constructor.
  static final ImageConstants _instance = ImageConstants._init();
  
  // Sınıfın dışından erişilebilen tekil örnek için bir getter.
  static ImageConstants get instance => _instance;

  // Bu, yeni örneklerin dışarıdan oluşturulmasını engeller.
  ImageConstants._init();

  // PNG formatında bir resim dosyasının yolunu oluşturmak için kullanılan metod.
  String toPng(String name) => 'assets/images/$name.png';

  // SVG formatında bir resim dosyasının yolunu oluşturmak için kullanılan metod.
  String toSvg(String name) => 'assets/images/$name.svg';

  // Getter'ler.
  String get logo => toPng('logo');
  String get splashLogo => toPng('logo_s');
  String get google => toPng('google');
}
