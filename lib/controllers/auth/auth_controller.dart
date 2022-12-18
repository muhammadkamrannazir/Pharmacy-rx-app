import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pharmacy_rx/Services/auth_service.dart';
import 'package:pharmacy_rx/Services/firestore_services.dart';
import 'package:pharmacy_rx/models/Auth/pharmacy_model.dart';
import 'package:pharmacy_rx/utils/alert.dart';
import 'package:pharmacy_rx/views/pages/home.dart';

class AuthController extends GetxController {
  RxBool agreeClicked = false.obs;
  void agreeChange(bool value) {
    agreeClicked.value = value;
    update();
  }

  //--------> Password Visibility
  var obsecureLoginPass = true.obs;
  var obsecureSignUpPass = true.obs;

  final RxBool showWaitButton = false.obs;

  late String pharmacyName, email, password, confirmPassword;

  //------------------------> Database instances
  String USERS_COLLECTION = 'Users';

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final PharmacyModel _userModel = PharmacyModel();

  //------------------------> Login and Sign Up Screens Controllers

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController pharmacyController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController resetEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();
//--------------------------> Login Button Functionality

  loginAccount() async {
    email = loginEmailController.text.trim();
    password = passwordController.text.trim();

    if (formkey[0].currentState!.validate()) {
      showWaitButton.value = true;
      bool result = await AuthServices.login(email, password);
      if (result == true) {
        resetSignInFields();
        Fluttertoast.showToast(msg: 'Login Successful');
        Get.to(Home());
      }
      showWaitButton.value = false;
    }
  }

//--------------------------> Sign Up Button Functionality
  createAccount() async {
    pharmacyName = pharmacyController.text.trim();
    email = signUpEmailController.text.trim();
    password = signUpPasswordController.text.trim();
    confirmPassword = signUpConfirmPasswordController.text.trim();

    if (formkey[1].currentState!.validate()) {
      showWaitButton.value = true;

      formkey[1].currentState!.save();
      // check is pharmacyName already exist or not
      bool alreadyExist = await FireStoreServices.ispharmacyNameExist(
          pharmacyController.value.text);
      if (alreadyExist) {
        showWaitButton(false);
        MyAlert.showToast("This pharmacyName already exist.");
        return;
      }
      bool result = await AuthServices.signUp(email, password);
      if (result == true) {
        postDetailsToFirebase();
      } else {
        showWaitButton.value = false;
      }
    }
  }
//--------------------------> Post Details To Firebase

  postDetailsToFirebase() async {
    User? user = _auth.currentUser;
    _userModel.pharmacyId = user!.uid;
    _userModel.email = signUpEmailController.text.trim();
    _userModel.pharmacyName = pharmacyController.text.trim();

    await FireStoreServices.uploadPharmacyData(_userModel).then((value) {
      resetSignUpFields();
      Get.to(Home());
    }).onError((error, stackTrace) {
      MyAlert.showToast(error.toString());
    });
    showWaitButton.value = false;
  }

  resetSignUpFields() {
    pharmacyController.text = '';
    signUpEmailController.text = '';
    signUpPasswordController.text = '';
    signUpConfirmPasswordController.text = '';
  }

  resetSignInFields() {
    loginEmailController.text = '';
    passwordController.text = '';
  }

  // --------------------> Login and Sign Up Screens Keys
  // final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  List<GlobalKey<FormState>> formkey = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  resetAccount() async {
    showWaitButton.value = true;
    if (formkey[2].currentState!.validate()) {
      email = resetEmailController.text.trim();
      bool result = await AuthServices.resetPassword(email);
      if (result == true) {
        Fluttertoast.showToast(msg: 'Reset Link sent Successfully');
      }
    }
    showWaitButton.value = false;
  }
}
