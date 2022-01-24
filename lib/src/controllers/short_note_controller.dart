import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../repository/user_repository.dart' as repository;

class ShortNoteController extends ControllerMVC {
  GlobalKey<FormState> shortNoteFormKey;
  GlobalKey<ScaffoldState> shortNoteScaffoldKey;

  ShortNoteController() {
    shortNoteFormKey = new GlobalKey<FormState>();
    this.shortNoteScaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void storeNote(String shortNote) async {
    Navigator.of(context).pop();
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.green));
    repository.storeNote(shortNote).then((value) {
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
              message: "Short note updated successfully",
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