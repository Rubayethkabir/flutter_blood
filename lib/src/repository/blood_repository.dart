import 'package:TenTwelveBlood/src/applications/amarpk_api.dart';
import 'package:TenTwelveBlood/src/applications/classes/blood/blood.dart';
import 'package:TenTwelveBlood/src/applications/classes/blood/blood_list.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/user_repository.dart';
import 'package:dio/dio.dart';

abstract class BloodRepository {
  Future<BloodList> getAllBloodList(String groupIndex,int page, String searchValue);
}

class BloodReositoryImpl implements BloodRepository {
  @override 
  Future<BloodList> getAllBloodList(String groupName,int page, String searchValue) async {
      
    try { 
    
      String _apiToken = currentUser.value.apiToken;
      String userId = currentUser.value.id;
      
      String finalUrl = '/api/blood/$groupName/$userId?page=$page&searching=$searchValue';
      final response = await AmarpkApi.dio.get(finalUrl,
         options: Options(headers: {
           'Authorization' : "Bearer "+_apiToken,
         })); 

      List _temp = response.data['data'];
      var _meta = response.data['meta'];
      Pagination pagination = Pagination.fromJson(_meta);
      List<Blood> _bloodList = _temp.map((blood) => Blood.formJson(blood)).toList();
      return new BloodList(pagination: pagination, bloodList: _bloodList);

    } on DioError catch(e) {
      print(e);
      // throw showNetworkError(e);
      throw Error();
    }
  }
}