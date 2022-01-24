import 'package:TenTwelveBlood/src/applications/about_us/about_us_class.dart';
import 'package:TenTwelveBlood/src/applications/about_us/about_us_list.dart';
import 'package:TenTwelveBlood/src/applications/amarpk_api.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/user_repository.dart';
import 'package:dio/dio.dart';

abstract class AboutUsRepository {
  Future<AboutUsList> getAllAboutUsList(int type,int page);
}

class AboutUsRepositoryImpl implements AboutUsRepository {
  @override 
  Future<AboutUsList> getAllAboutUsList(int type,int page) async {
    final String _apiToken = currentUser.value.apiToken;
    try {
      final response = await AmarpkApi.dio.get("/api/about-us-all/$type?page=$page",
         options: Options(headers: {
           'Authorization' : "Bearer "+_apiToken
         })); 
        
      print(response);
      List _temp = response.data['data'];
      var _meta = response.data['meta'];
      Pagination pagination = Pagination.fromJson(_meta);
      List<AboutUsClass> _aboutUsList = _temp.map((aboutUs) => AboutUsClass.formJson(aboutUs)).toList();
      return new AboutUsList(pagination: pagination, aboutUsList: _aboutUsList);

    } on DioError catch(e) {
      // throw showNetworkError(e);
      throw new Exception(e);
    }
  }
}