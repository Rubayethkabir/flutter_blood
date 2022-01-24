import '../helpers/custom_trace.dart';

class Otp {
  
  String mobile;
  String otpCode;
  int pendingId;
  String newResetPassword;
  String retypeResetPassword;

  Otp();

  Otp.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      mobile = jsonMap['mobile'] != null ? jsonMap['mobile'] : '';
      otpCode = jsonMap['otpCode'];
      pendingId = jsonMap['pendingId'] != null ? jsonMap['pendingId'] : 0;
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["mobile"] = mobile;
    map["otpCode"] = otpCode;
    map["pendingId"] = pendingId;
    return map;
  }

  Map toMapFogotPassword() {
    var map = new Map<String, dynamic>();
    map["mobile"] = mobile;
    map["pendingId"] = pendingId;
    map["newResetPassword"] = newResetPassword;
    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["mobile"] = mobile;
    map["otpCode"] = otpCode;
    map["pendingId"] = pendingId;
    return map;
  }

}
