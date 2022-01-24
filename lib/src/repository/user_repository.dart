import 'dart:convert';
import 'dart:io';

import 'package:TenTwelveBlood/src/applications/base_url.dart';
import 'package:TenTwelveBlood/src/models/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../models/user.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

String pendingMobile;
int pendingUserId;
var pendingUser;

Future<User> login(User user) async {
  final String url = BASE_URL + '/api/auth/login';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    // throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<User> register(Otp otp) async {
  final String url = BASE_URL+'/api/auth/otp-confirm';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(otp.toMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    // throw new Exception(response.body);
    
  }
  return currentUser.value;
}


Future<User> otpSend(User user) async {
  // final String url = '${GlobalConfiguration().getValue('api_base_url')}sent-otp';
  final String url = BASE_URL +'/api/auth/sent-otp';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  if (response.statusCode == 200) {
    user.otpSent = true;
    int pendingUserId = json.decode(response.body)['data']['id'];
    setPendingMobile(user.mobile);
    setPendingUserId(pendingUserId);
  } else {
    user.otpSent = false;
    user.errorMessage = 'Something went wrong, please contact with system admin.[001]';
    if(json.decode(response.body)['errors']['mobile'][0] != ''){
      user.errorMessage =  json.decode(response.body)['errors']['mobile'][0];
    }
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    
    // throw new Exception(response.body);
  }
  return user;
}

Future<User> directRegister(User user) async {
  // final String url = '${GlobalConfiguration().getValue('api_base_url')}sent-otp';
  final String url = BASE_URL +'/api/auth/direct-registration';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    // throw new Exception(response.body);
    
  }
  return currentUser.value;
}

Future<User> forgotPasswordOtp(User user) async {
  final String url = BASE_URL +'/api/auth/sent-otp-forgot-password';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMapOnlyMobile()),
  );

  if (response.statusCode == 200) {
    user.otpSent = true;
    int pendingUserId = json.decode(response.body)['data']['id'];
    setPendingMobile(user.mobile);
    setPendingUserId(pendingUserId);
  } else {
    user.otpSent = false;
    user.errorMessage = 'Something went wrong, please contact with system admin.[001]';
    if(json.decode(response.body)['errors'] != ''){
      user.errorMessage =  json.decode(response.body)['errors'];
    }
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    
    // throw new Exception(response.body);
  }
  return user;
}

Future<User> forgotOtpConfirm(Otp otp) async {
  final String url = BASE_URL+'/api/auth/otp-confirm-forgot-password';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(otp.toMap()),
  );

  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    currentUser.value.errorMessage = '';
  } else {
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    // throw new Exception(response.body);
    
  }
  return currentUser.value;
}

Future<User> setPasswordConfirm(Otp otp) async {
  final String url = BASE_URL+'/api/auth/forgot-password-reset';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(otp.toMapFogotPassword()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    // throw new Exception(response.body);
    
  }
  return currentUser.value;
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  try {
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: jsonString).toString());
    throw new Exception(e);
  }
}

void setPendingMobile(String mobile) async {
  try {
    if (mobile != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('pending_mobile',mobile);
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: 'mobile store error').toString());
    throw new Exception(e);
  }
}

void setPendingUserId(int id) async {
  try {
    if (id != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('pending_id',id);
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: 'id store error').toString());
    throw new Exception(e);
  }
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if ( prefs.containsKey('current_user')) {
    currentUser.value = User.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  }else{
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<void> setInitialRoute() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('current_user')) {
    currentUser.value.auth = false;
  }
  currentUser.value.auth = true;
}

dynamic getPendingMobile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if ( prefs.containsKey('pending_mobile')) {
    pendingMobile = await prefs.getString('pending_mobile');
  } else {
    pendingMobile = null;
  }
  return pendingMobile;
}


dynamic getPendingUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if ( prefs.containsKey('pending_id')) {
    pendingUserId = await prefs.getInt('pending_id');
  } else {
    pendingUserId = null;
  }
  return pendingUserId;
}

Future<User> update(User user) async {
  final String _apiToken = currentUser.value.apiToken;
  final String url = BASE_URL+'/api/users/${currentUser.value.id}';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json', 'Authorization' : 'Bearer '+ _apiToken},
    body: json.encode(user.toMap()),
  );

  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value.errorMessage = '';
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    
  }else{
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
  }
  return currentUser.value;
}

Future<User> storeNote(String shortNote) async {
  Map data = {
    'shortNote' : shortNote
  };
  final String _apiToken = currentUser.value.apiToken;
  final String url = BASE_URL+'/api/users-add-note/${currentUser.value.id}';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json', 'Authorization' : 'Bearer '+ _apiToken},
    body: json.encode(data),
  );

  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value.errorMessage = '';
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    
  }else{
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
  }
  return currentUser.value;
}

Future<User> updateDate(dynamic dateData) async {
  currentUser.value.lastBloodGivenDate = dateData.toString();

  Map data = {
    'dateData': dateData.toString()
  };
  
  final String _apiToken = currentUser.value.apiToken;
  final String url = BASE_URL+"/api/users-date-update/${currentUser.value.id}";
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json', 'Authorization' : 'Bearer '+ _apiToken},
    body: json.encode(data)
  );

  print(json.decode(response.body)['data']);

  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value.errorMessage = '';
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    
  }else{
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
  }
  return currentUser.value;
}

Future<User> changePassword(User user) async {

  print(json.encode(user.toChangePasswordMap()));

  final String _apiToken = currentUser.value.apiToken;
  final String url = BASE_URL+'/api/users-change-password/${currentUser.value.id}';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json', 'Authorization' : 'Bearer '+ _apiToken},
    body: json.encode(user.toChangePasswordMap()),
  );

  if (response.statusCode == 200) {
    currentUser.value.errorMessage = '';    
  }else{
    currentUser.value.errorMessage = 'Something went wrong Please contact with system admin';
    if(json.decode(response.body)['errors'] != ''){
      currentUser.value.errorMessage =  json.decode(response.body)['errors'];
    }
  }
  return currentUser.value;
}


