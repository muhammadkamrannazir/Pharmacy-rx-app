import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pharmacy_rx/utils/app_colors.dart';

customSnackBar(String title, String detail) {
  Get.snackbar(
    title,
    detail,
    backgroundColor: MyColor.blue,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
  );
}

