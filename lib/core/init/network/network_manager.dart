import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/app/app_constants.dart';

/// `NetworkManager`, ağ işlemleri için merkezi bir yönetim sağlayan sınıftır.
/// Dio paketi kullanılarak HTTP istekleri gerçekleştirir.
class NetworkManager {
  static NetworkManager? _instance;

  // Singleton deseni ile sınıfın tek bir örneğini oluşturur.
  static NetworkManager get instance {
    _instance ??= NetworkManager._init();
    return _instance!;
  }

  // Dio için temel ayarların yapıldığı özel constructor.
  NetworkManager._init() {
    const baseUrl = ApplicationConstants.baseApiUrl;
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.formUrlEncodedContentType,
    );
    _dio = Dio(baseOptions);
  }

  late final Dio _dio;

  /// Verilen yola ve veriye göre POST isteği gönderir.
  Future<dynamic> dioPost({required String path, required Map data}) async {
    Map<String, dynamic> updatedData = Map<String, dynamic>.from(data);

    if (kDebugMode) {
      log('LOG (Giden Veri): $updatedData');
    }
    try {
      final response = await _dio.post(path, data: updatedData);
      if (_isSuccessfulStatusCode(response.statusCode)) {
        if (kDebugMode) {
          log('LOG (Gelen Veri): ${response.data}');
        }
        return response.data;
      } else {
        if (kDebugMode) {
          log('LOG (Gelen Veri): ${response.toString()}');
        }
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        // DioError durumunda ilgili hata logu basılır.
        _handleDioError(e);
      } else {
        // DioError dışındaki hatalar için log basılır.
        if (kDebugMode) {
          log('LOG (Gelen Veri) (Not DioError): ${e.toString()}');
        }
        return null;
      }
    }
  }

  /// HTTP durum kodunun başarılı olup olmadığını kontrol eder.
  bool _isSuccessfulStatusCode(int? statusCode) {
    return statusCode != null &&
        (statusCode == HttpStatus.ok ||
            statusCode == HttpStatus.created ||
            statusCode == HttpStatus.accepted);
  }

  /// DioError durumunda hata logunu basar ve hatayı döner.
  void _handleDioError(DioException e) {
    if (e.response?.data == null) {
      if (kDebugMode) {
        log('LOG (Gelen Veri) (DioError): NULL | Status Code: ${e.response?.statusCode}');
      }
    } else {
      if (kDebugMode) {
        log('LOG (Gelen Veri) (DioError): ${e.response?.data} ');
      }
    }
  }
}
