import 'package:TenTwelveBlood/src/applications/base_url.dart';
import 'package:dio/dio.dart';

class AmarpkApi {
  static BaseOptions _baseOptions = new BaseOptions(baseUrl: BASE_URL);

  // For unauthenticated apis
  static Dio dio = new Dio(_baseOptions);

  // Autheticated routes
  static Dio dioAuth() {
    return Dio();
  }
}
