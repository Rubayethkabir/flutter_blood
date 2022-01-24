import 'package:TenTwelveBlood/src/applications/amarpk_api.dart';
import 'package:TenTwelveBlood/src/applications/classes/hospital/hospital_class.dart';
import 'package:TenTwelveBlood/src/applications/classes/hospital/hospital_list.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/user_repository.dart';
import 'package:dio/dio.dart';

abstract class HospitalRepository {
  Future<HospitalList> getAllHospitalList(int page);
}

class HospitalReositoryImpl implements HospitalRepository {
  @override 
  Future<HospitalList> getAllHospitalList(int page) async {
    try {
      final String  _apiToken = currentUser.value.apiToken;
      final response = await AmarpkApi.dio.get("/api/hospital-all?page=$page",
         options: Options(headers: {
           'Authorization' : "Bearer "+_apiToken
         })); 
      List _temp = response.data['data'];
      var _meta = response.data['meta'];
      Pagination pagination = Pagination.fromJson(_meta);
      List<HospitalClass> _hospitalList = _temp.map((hospital) => HospitalClass.formJson(hospital)).toList();
      return new HospitalList(pagination: pagination, hospitalList: _hospitalList);

    } on DioError catch(e) {
      // throw showNetworkError(e);
       throw Error();
    }
  }
}