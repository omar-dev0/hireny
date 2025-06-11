import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showError(String error)
{
  Fluttertoast.showToast(
    msg: error,
    backgroundColor: Colors.redAccent,
    textColor: Colors.white,
    gravity: ToastGravity.TOP,
  );
}