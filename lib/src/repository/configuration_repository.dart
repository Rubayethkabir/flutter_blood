import 'package:TenTwelveBlood/src/applications/amarpk_api.dart';
import 'package:TenTwelveBlood/src/applications/classes/configuration/configuration_class.dart';
import 'package:TenTwelveBlood/src/applications/classes/configuration/configuration_data.dart';
import 'package:TenTwelveBlood/src/repository/user_repository.dart';
import 'package:dio/dio.dart';

abstract class ConfigurationRepository {
  Future getConfiguration(String caption);
}

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  
  @override 
  Future getConfiguration(String caption) async{
    final String _apiToken = currentUser.value.apiToken;
    try {
      final response = await AmarpkApi.dio.get("/api/configuration/$caption",
              options: Options(headers: {
                'Authorization' : "Bearer "+ _apiToken
              })
            );
      var temp = response.data['data'];
      ConfigurationClass configurationData = ConfigurationClass.formJson(temp);
      return new ConfigurationData(configuration: configurationData);        
    }on DioError catch(e) {
      throw Error();
    }
  }
}
