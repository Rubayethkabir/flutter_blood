import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void update(User user) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.green));
    // user.deviceToken = null;
    repository.update(user).then((value) {
      Loader.hide();
      setState(() {});
      if (value.errorMessage != '') {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "profile settings updated successfully",
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

  void updateDate(dateData) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.green));
    // user.deviceToken = null;
    repository.updateDate(dateData).then((value) {
      Loader.hide();
    
      if (value.errorMessage != '') {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Date updated successfully",
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
  void changePassword(User user) async {
    if(user.newPassword == user.reTypeNewPassword){
      Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.green));

      repository.changePassword(user).then((value) {
        Loader.hide();
        if(value.errorMessage != '') {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: value.errorMessage,
            ),
          );
        
        }else{
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Password change successfully",
            ),
          );
        }
      });
    }else{
      showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "New password and Retype new password should be equal",
            ),
          );
    }
  }
}
