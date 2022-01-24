import '../helpers/custom_trace.dart';

enum UserState { available, away, busy }

class User {
  String id;
  String name;
  String email;
  String zone;
  String blood;
  String mobile;
  String bloodContactNumber;
  String lastBloodGivenDate;
  String diffDays;
  String shortNote;
  String picture;
  String password;
  String errorMessage;
  String apiToken;
  bool auth;
  bool otpSent;
  String currentPassword;
  String newPassword;
  String reTypeNewPassword;
  bool isLogin;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      picture = jsonMap['picture'] != null ? jsonMap['picture'] : '';
      zone = jsonMap['zone'] != null ? jsonMap['zone'] : '';
      lastBloodGivenDate = jsonMap['lastBloodGivenDate'] != null
          ? jsonMap['lastBloodGivenDate']
          : '';
      diffDays = jsonMap['diffDays'] != null ? jsonMap['diffDays'] : '';
      blood = jsonMap['blood'] != null ? jsonMap['blood'] : '';
      shortNote = jsonMap['shortNote'] != null ? jsonMap['shortNote'] : '';
      mobile = jsonMap['mobile'] != null ? jsonMap['mobile'].toString() : '';
      bloodContactNumber = jsonMap['bloodContactNumber'] != null
          ? jsonMap['bloodContactNumber'].toString()
          : '';
      errorMessage =
          jsonMap['errorMessage'] != null ? jsonMap['errorMessage'] : '';
      apiToken = jsonMap['api_token'] != null ? jsonMap['api_token'] : '';
      auth = jsonMap['auth'] != null ? jsonMap['auth'] : false;
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  User.fromString(String errorString) {
    try {
      errorMessage = errorString;
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["zone"] = zone;
    map["blood"] = blood;
    map["mobile"] = mobile;
    map["bloodContactNumber"] = bloodContactNumber;
    return map;
  }

  Map toMapOnlyMobile() {
    var map = new Map<String, dynamic>();
    map["mobile"] = mobile;
    return map;
  }

  Map toChangePasswordMap() {
    var map = new Map<String, dynamic>();
    map["currentPassword"] = currentPassword;
    map["newPassword"] = newPassword;
    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["zone"] = zone;
    map["blood"] = blood;
    map["mobile"] = mobile;
    map["bloodContactNumber"] = bloodContactNumber;
    return map;
  }
}
