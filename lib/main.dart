import 'dart:io';
import 'package:TenTwelveBlood/src/applications/state/about_us/about_us_state.dart';
import 'package:TenTwelveBlood/src/applications/state/blood/blood_state.dart';
import 'package:TenTwelveBlood/src/applications/state/configuration/configuration_state.dart';
import 'package:TenTwelveBlood/src/applications/state/doctor/doctor_state.dart';
import 'package:TenTwelveBlood/src/applications/state/hospital/hospital_state.dart';
import 'package:TenTwelveBlood/src/applications/state/medical_tip/medical_tip_state.dart';
import 'package:TenTwelveBlood/src/repository/about_us_repository.dart';
import 'package:TenTwelveBlood/src/repository/blood_repository.dart';
import 'package:TenTwelveBlood/src/repository/configuration_repository.dart';
import 'package:TenTwelveBlood/src/repository/doctor_repository.dart';
import 'package:TenTwelveBlood/src/repository/hospital_repository.dart';
import 'package:TenTwelveBlood/src/repository/medical_tip_repository.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'route_generator.dart';
import 'src/helpers/app_config.dart' as config;
import 'src/models/setting.dart';
import 'src/repository/settings_repository.dart' as settingRepo;
import 'src/repository/user_repository.dart' as userRepo;

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await userRepo.setInitialRoute();
  await settingRepo.initSettings();
  await userRepo.getCurrentUser();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Injector(
        inject: [
          Inject<AboutUsState>(() => AboutUsState(AboutUsRepositoryImpl())),
          Inject<BloodState>(() => BloodState(BloodReositoryImpl())),
          Inject<MedicalTipState>(
              () => MedicalTipState(MedicalTipRepositoryImpl())),
          Inject<HospitalState>(() => HospitalState(HospitalReositoryImpl())),
          Inject<DoctorState>(() => DoctorState(DoctorRepositoryImpl())),
          Inject<ConfigurationState>(
              () => ConfigurationState(ConfigurationRepositoryImpl())),
        ],
        builder: (context) {
          return ValueListenableBuilder(
              valueListenable: settingRepo.setting,
              builder: (context, Setting _setting, _) {
                return MaterialApp(
                    navigatorKey: settingRepo.navigatorKey,
                    title: 'TenTwelve', // _setting.appName,
                    initialRoute: (userRepo.currentUser.value.auth)
                        ? '/Dashboard'
                        : '/SignIn',
                    // initialRoute: '/Dashboard',
                    onGenerateRoute: RouteGenerator.generateRoute,
                    debugShowCheckedModeBanner: false,
                    theme: _setting.brightness.value == Brightness.light
                        // theme: Brightness.light == Brightness.light
                        ? ThemeData(
                            fontFamily: 'Poppins',
                            primaryColor: Colors.white,
                            floatingActionButtonTheme:
                                FloatingActionButtonThemeData(
                                    elevation: 0,
                                    foregroundColor: Colors.white),
                            brightness: Brightness.light,
                            accentColor: config.Colors().mainColor(1),
                            dividerColor: config.Colors().accentColor(0.1),
                            focusColor: config.Colors().accentColor(1),
                            hintColor: config.Colors().secondColor(1),
                            textTheme: TextTheme(
                              headline5: TextStyle(
                                  fontSize: 20.0,
                                  color: config.Colors().secondColor(1),
                                  height: 1.35),
                              headline4: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: config.Colors().secondColor(1),
                                  height: 1.35),
                              headline3: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: config.Colors().secondColor(1),
                                  height: 1.35),
                              headline2: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700,
                                  color: config.Colors().mainColor(1),
                                  height: 1.35),
                              headline1: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w300,
                                  color: config.Colors().secondColor(1),
                                  height: 1.5),
                              subtitle1: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: config.Colors().secondColor(1),
                                  height: 1.35),
                              headline6: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: config.Colors().mainColor(1),
                                  height: 1.35),
                              bodyText2: TextStyle(
                                  fontSize: 12.0,
                                  color: config.Colors().secondColor(1),
                                  height: 1.35),
                              bodyText1: TextStyle(
                                  fontSize: 14.0,
                                  color: config.Colors().secondColor(1),
                                  height: 1.35),
                              caption: TextStyle(
                                  fontSize: 12.0,
                                  color: config.Colors().accentColor(1),
                                  height: 1.35),
                            ),
                          )
                        : ThemeData(
                            fontFamily: 'Poppins',
                            primaryColor: Color(0xFF252525),
                            brightness: Brightness.dark,
                            scaffoldBackgroundColor: Color(0xFF2C2C2C),
                            accentColor: config.Colors().mainDarkColor(1),
                            dividerColor: config.Colors().accentColor(0.1),
                            hintColor: config.Colors().secondDarkColor(1),
                            focusColor: config.Colors().accentDarkColor(1),
                            textTheme: TextTheme(
                              headline5: TextStyle(
                                  fontSize: 20.0,
                                  color: config.Colors().secondDarkColor(1),
                                  height: 1.35),
                              headline4: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: config.Colors().secondDarkColor(1),
                                  height: 1.35),
                              headline3: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: config.Colors().secondDarkColor(1),
                                  height: 1.35),
                              headline2: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700,
                                  color: config.Colors().mainDarkColor(1),
                                  height: 1.35),
                              headline1: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w300,
                                  color: config.Colors().secondDarkColor(1),
                                  height: 1.5),
                              subtitle1: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: config.Colors().secondDarkColor(1),
                                  height: 1.35),
                              headline6: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: config.Colors().mainDarkColor(1),
                                  height: 1.35),
                              bodyText2: TextStyle(
                                  fontSize: 12.0,
                                  color: config.Colors().secondDarkColor(1),
                                  height: 1.35),
                              bodyText1: TextStyle(
                                  fontSize: 14.0,
                                  color: config.Colors().secondDarkColor(1),
                                  height: 1.35),
                              caption: TextStyle(
                                  fontSize: 12.0,
                                  color: config.Colors().secondDarkColor(0.6),
                                  height: 1.35),
                            ),
                          ));
              });
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
