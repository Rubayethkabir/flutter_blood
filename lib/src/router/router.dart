import 'package:TenTwelveBlood/src/pages/health/doctor.dart';
import 'package:TenTwelveBlood/src/pages/health/health.dart';
import 'package:TenTwelveBlood/src/pages/health/health_tips_details.dart';
import 'package:TenTwelveBlood/src/pages/health/hospital.dart';
import 'package:TenTwelveBlood/src/router/route_constants.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case healthRoute:
        return MaterialPageRoute(builder: (_) => Health());
      case hospitalRoute:
        return MaterialPageRoute(builder: (_) => Hospital());
      case doctorRoute:
        return MaterialPageRoute(builder: (_) => Doctor());
      case medicalTipDetailsRoute:
        return MaterialPageRoute(settings : routeSettings,builder: (_) => HealthTipsDetials());
      
      default:
        // return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
