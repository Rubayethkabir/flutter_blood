import 'package:TenTwelveBlood/src/applications/classes/configuration/configuration_class.dart';
import 'package:TenTwelveBlood/src/applications/classes/configuration/configuration_data.dart';
import 'package:TenTwelveBlood/src/repository/configuration_repository.dart';

class ConfigurationState {
  final ConfigurationRepository _configurationRepository;
  ConfigurationState(this._configurationRepository);

  ConfigurationClass configurationData;
  ConfigurationClass get getConfigurationData => configurationData;

  String bloodContent;
  String get getBloodContent => bloodContent;

  bool _loading = false;
  bool get loading => _loading;

  Future getConfiguration(String caption) async{
    _loading = true;
    ConfigurationData  newConfigData = await _configurationRepository.getConfiguration(caption);
    configurationData = newConfigData.configuration;
    switch (caption) {
      case 'BLOOD_CONTENT' : {
        bloodContent = configurationData.details;
        break;
      }
      default : {
        configurationData = newConfigData.configuration;
      }
    }

    _loading = false;
  }
}