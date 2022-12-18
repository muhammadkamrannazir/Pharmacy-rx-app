
import 'package:get/get.dart';

class HistoryController extends GetxController {
  RxBool agreeClicked = false.obs;
  void agreeChange(bool value) {
    agreeClicked.value = value;
    update();
  }
}
