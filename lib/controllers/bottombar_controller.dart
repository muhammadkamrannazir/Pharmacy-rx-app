import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_rx/views/pages/others/add_medicine.dart';

class LandingPageController extends GetxController {
  // final LandingPageController landingPageController = Get.put(
  //   LandingPageController(),
  //   permanent: false,
  // );

  


  var tabIndex = 0.obs;
  var title = 'Home'.obs;

  void changeTabIndex(int index) {
    changeTitle(index);
    tabIndex.value = index;
  }

  void changeTitle(int index) {
    switch (index) {
      case 0:
        title.value = 'Home';
        break;
      case 1:
        title.value = 'Task Details';
        break;
      case 2:
        title.value = '';
        Get.bottomSheet(
          AddMedicine(),
          isDismissible: true,
          isScrollControlled: true,
        );
        break;
      case 3:
        title.value = 'Notification';
        break;
      case 4:
        title.value = '';
        break;
    }
  }
}
