import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../helpers/helper.dart';
import '../models/otp.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  Otp otp = new Otp();
  bool hidePassword = true;
  bool loading = false;

  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> otpFormKey;
  GlobalKey<FormState> forgotOtpFormKey;
  GlobalKey<FormState> signUpFormKey;
  GlobalKey<FormState> forgotPasswordKey;
  GlobalKey<FormState> resetPasswordFormKey;

  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<ScaffoldState> otpScaffoldKey;
  GlobalKey<ScaffoldState> forgotOtpScaffoldKey;
  GlobalKey<ScaffoldState> resetPasswordScaffoldKey;
  GlobalKey<ScaffoldState> fogotPasswordScaffoldKey;

  OverlayEntry loader;

  UserController() {
    loader = Helper.overlayLoader(context);

    loginFormKey = new GlobalKey<FormState>();
    signUpFormKey = new GlobalKey<FormState>();
    otpFormKey = new GlobalKey<FormState>();
    forgotPasswordKey = new GlobalKey<FormState>();
    forgotOtpFormKey = new GlobalKey<FormState>();
    resetPasswordFormKey = new GlobalKey<FormState>();

    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.otpScaffoldKey = new GlobalKey<ScaffoldState>();
    this.fogotPasswordScaffoldKey = new GlobalKey<ScaffoldState>();
    this.forgotOtpScaffoldKey = new GlobalKey<ScaffoldState>();
    this.resetPasswordScaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void login() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.green));

      repository.login(user).then((value) {
        Loader.hide();
        if (value != null && value.apiToken != null && value.apiToken != '') {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: 'Successfully Sign in, Thank you',
            ),
          );

          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/Dashboard');
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        }
      }).catchError((e) {
        Loader.hide();

        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: 'Something went wrong, Please contact with system admin',
          ),
        );
      }).whenComplete(() {
        Loader.hide();
      });
    }
  }

  void register() async {
    if (otpFormKey.currentState.validate()) {
      otpFormKey.currentState.save();

      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.green));

      String pendingMobile = await repository.getPendingMobile();
      int pendingId = await repository.getPendingUserId();
      otp.mobile = pendingMobile;
      otp.pendingId = pendingId;
      repository.register(otp).then((value) {
        Loader.hide();
        if (value != null && value.apiToken != null) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Register successfully, Thank You",
            ),
          );
          Navigator.of(otpScaffoldKey.currentContext)
              .pushReplacementNamed('/Dashboard');
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        }
      }).catchError((e) {
        Loader.hide();
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Something went wrong, Please contact with system admin..",
          ),
        );
      }).whenComplete(() {
        Loader.hide();
      });
    } else {
      otpScaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Please fill up all field with valid data'),
      ));
    }
  }

  void otpMechamism() async {
    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();

      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.green));

      repository.otpSend(user).then((value) {
        Loader.hide();
        if (value.otpSent) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message:
                  "A code sent to your mobile, please check and submit by this code",
            ),
          );
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Otp');
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        }
      }).catchError((e) {
        Loader.hide();
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Something went wrong, Contact with system admin.",
          ),
        );
      }).whenComplete(() {
        Loader.hide();
      });
    }
  }

  //** For Direct registration without otp **/

  void directRegistration() async {
    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();

      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.green));

      // repository.otpSend(user).then((value) {
      repository.directRegister(user).then((value) {
        Loader.hide();
        if(value.apiToken != null){
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Register successfully, Thank You",
            ),
          );
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Dashboard');
        }else{ 
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        }
      }).catchError((e) {
        Loader.hide();
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Something went wrong, Contact with system admin.",
          ),
        );
      }).whenComplete(() {
        Loader.hide();
      });
    }
  }

  void forgotPasswordOtp() {
    if (forgotPasswordKey.currentState.validate()) {
      forgotPasswordKey.currentState.save();

      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.green));

      repository.forgotPasswordOtp(user).then((value) {
        Loader.hide();
        if (value.otpSent) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message:
                  "A code sent to your mobile, please check and submit by this code",
            ),
          );
          print(value);
          Navigator.of(fogotPasswordScaffoldKey.currentContext)
              .pushReplacementNamed('/OtpForgotPassword');
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        }
      }).whenComplete(() {
        Loader.hide();
      });
    }
  }

  void fogotPasswordOtpConfirm() async {
    if (forgotOtpFormKey.currentState.validate()) {
      forgotOtpFormKey.currentState.save();

      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.green));

      String pendingMobile = await repository.getPendingMobile();
      int pendingId = await repository.getPendingUserId();
      otp.mobile = pendingMobile;
      otp.pendingId = pendingId;

      repository.forgotOtpConfirm(otp).then((value) {
        Loader.hide();
        if (value.errorMessage == '') {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Otp Confirm successfully, Thank You",
            ),
          );
          Navigator.of(forgotOtpScaffoldKey.currentContext)
              .pushReplacementNamed('/ResetPassord');
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        }
      }).catchError((e) {
        Loader.hide();
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Something went wrong, Please contact with system admin..",
          ),
        );
      }).whenComplete(() {
        Loader.hide();
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Something went wrong, Please contact with system admin..",
        ),
      );
    }
  }

  void setResetPassword() async {
    if (resetPasswordFormKey.currentState.validate()) {
      resetPasswordFormKey.currentState.save();

      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          themeData: Theme.of(context).copyWith(accentColor: Colors.green));

      String pendingMobile = await repository.getPendingMobile();
      int pendingId = await repository.getPendingUserId();
      otp.mobile = pendingMobile;
      otp.pendingId = pendingId;

      if (otp.newResetPassword != otp.retypeResetPassword) {
        Loader.hide();
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: 'New password and retype password should be equal..',
          ),
        );
      } else {
        repository.setPasswordConfirm(otp).then((value) {
          Loader.hide();
          if (value != null && value.apiToken != null) {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: "Password reset successfully, Thank You",
              ),
            );
            Navigator.of(resetPasswordScaffoldKey.currentContext)
                .pushReplacementNamed('/Dashboard');
          } else {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: value.errorMessage,
              ),
            );
          }
        }).catchError((e) {
          Loader.hide();
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message:
                  "Something went wrong, Please contact with system admin..",
            ),
          );
        }).whenComplete(() {
          Loader.hide();
        });
      }
    } else {
      Loader.hide();
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Please fillup all data correctly",
        ),
      );
    }
  }
}
