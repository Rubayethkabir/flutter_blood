import 'package:flutter/material.dart';

showSnackbar(
    {@required GlobalKey<ScaffoldState> key,
    @required String message,
    Color color}) {
  key.currentState.showSnackBar(
    SnackBar(
      // backgroundColor: color ?? brandingColor,
      backgroundColor: color ?? Colors.blue,
      content: Text(message),
    ),
  );
}

