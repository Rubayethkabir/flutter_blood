import 'package:TenTwelveBlood/src/applications/amarpk_api.dart';
import 'package:TenTwelveBlood/src/applications/classes/doctor/doctor_class.dart';
import 'package:TenTwelveBlood/src/applications/classes/doctor/doctor_list.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/user_repository.dart';
import 'package:dio/dio.dart';

abstract class DoctorRepository {
  Future<DoctorList> getAllDoctorList(int page);
}

class DoctorRepositoryImpl implements DoctorRepository {
  @override 
  Future<DoctorList> getAllDoctorList(int page) async {
    try {
      final String _apiToken = currentUser.value.apiToken;
      final response = await AmarpkApi.dio.get("/api/doctor-all?page=$page",
         options: Options(headers: {
           'Authorization' : "Bearer "+_apiToken
         })); 
      List _temp = response.data['data'];
      var _meta = response.data['meta'];
      Pagination pagination = Pagination.fromJson(_meta);
      List<DoctorClass> _doctorList = _temp.map((doctor) => DoctorClass.formJson(doctor)).toList();
      return new DoctorList(pagination: pagination, doctorList: _doctorList);

    } on DioError catch(e) {
      // throw showNetworkError(e);
      throw Error();
    }
  }
}