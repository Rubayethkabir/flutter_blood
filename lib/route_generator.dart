import 'package:TenTwelveBlood/src/pages/about_us.dart';
import 'package:TenTwelveBlood/src/pages/change_picture.dart';
import 'package:TenTwelveBlood/src/pages/dashboard.dart';
import 'package:TenTwelveBlood/src/pages/dedicated.dart';
import 'package:TenTwelveBlood/src/pages/forget_password.dart';
import 'package:TenTwelveBlood/src/pages/health/health.dart';
import 'package:TenTwelveBlood/src/pages/off_line_donor.dart';
import 'package:TenTwelveBlood/src/pages/otp_forgot_password_page.dart';
import 'package:TenTwelveBlood/src/pages/otp_page.dart';
import 'package:TenTwelveBlood/src/pages/profile_page.dart';
import 'package:TenTwelveBlood/src/pages/reset_password_page.dart';
import 'package:TenTwelveBlood/src/pages/settings.dart';
import 'package:TenTwelveBlood/src/pages/sign_in.dart';
import 'package:TenTwelveBlood/src/pages/user_profile.dart';
import 'package:flutter/material.dart';

import 'src/pages/sign_up.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/Otp':
        return MaterialPageRoute(builder: (_) => OtpPage());
      case '/OtpForgotPassword':
        return MaterialPageRoute(builder: (_) => OtpForgotPasswordPage());
      case '/ResetPassord':
        return MaterialPageRoute(builder: (_) => ResetPasswordPage());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignIn());
      case '/Offlinedonor':
        return MaterialPageRoute(builder: (_) => Offlinedonor());
      case '/ForgetPassword':
        return MaterialPageRoute(builder: (_) => ForgetPassword());
      case '/Dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/Dedicated':
        return MaterialPageRoute(builder: (_) => Dedicated());
      case '/AboutUs':
        return MaterialPageRoute(builder: (_) => AboutUs());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/ChangePicture':
        return MaterialPageRoute(builder: (_) => ChangePicture());
      case '/ProfilePage':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/UserProfile':
        return MaterialPageRoute(builder: (_) => UserProfile());
      case '/Health':
        return MaterialPageRoute(builder: (_) => Health());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Page not found contact with system admin'))));
    }
  }
}
