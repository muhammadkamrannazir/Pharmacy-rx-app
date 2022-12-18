import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_rx/utils/app_colors.dart';

class MyAlert {
  static void showToast(String txt) {
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColor.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}
