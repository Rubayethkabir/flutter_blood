import 'package:TenTwelveBlood/src/applications/amarpk_api.dart';
import 'package:TenTwelveBlood/src/applications/classes/medical_tip/medical_tip_list.dart';
import 'package:TenTwelveBlood/src/applications/classes/medical_tip/medical_tip_model.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/user_repository.dart';
import 'package:dio/dio.dart';


abstract class MedicalTipRepository {
  Future<MedicalTipList> getAllMedicalTip(int page);
}

class MedicalTipRepositoryImpl implements MedicalTipRepository {
  @override 
  Future<MedicalTipList> getAllMedicalTip(int page) async{
    try {
      final String _apiToken = currentUser.value.apiToken;
      final response = await AmarpkApi.dio.get('/api/medical-tips-all?page=$page',
        options: Options(
          headers: {
            'Authorization' : "Bearer "+_apiToken
          }
        )
      );
      var meta = response.data['meta'];
      List _tempData = response.data['data'];

      Pagination pagination = Pagination.fromJson(meta);
      List<MedicalTipModel> medicalTipList = _tempData.map((e) => MedicalTipModel.formJson(e)).toList();
      return new MedicalTipList(pagination: pagination, medicalTipList: medicalTipList);

    }on DioError catch(e) {
      // throw showNetworkError(e);
      throw Error();
    }
  }
}