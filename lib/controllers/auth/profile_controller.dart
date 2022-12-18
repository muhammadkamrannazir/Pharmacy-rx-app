import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_rx/Services/firestore_services.dart';
import 'package:pharmacy_rx/models/Auth/pharmacy_model.dart';
import 'package:pharmacy_rx/utils/alert.dart';

import '../../Services/auth_service.dart';
import '../../utils/snackbar.dart';

class ProfileController extends GetxController {
  final pharmacyNameController = TextEditingController().obs;
  final fullNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

  final currentPasswordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;
  final confirmNewPasswordController = TextEditingController().obs;

  var obsecureCurrentPass = true.obs;
  var obsecureNewPass = true.obs;
  var obsecureConfirmPass = true.obs;


  var updating=false.obs;
  var loading=false.obs;



  getPharmacyInfo() async {
    PharmacyModel userModel;
    loading(true);
     await FireStoreServices.getPharmacy().then((value){
       userModel=value;
       pharmacyNameController.value.text="${userModel.pharmacyName}";
       emailController.value.text="${userModel.email}";
     }).onError((error, stackTrace){
       MyAlert.showToast(error.toString());
     });
    loading(false);
  }

  updateUser() async {
    var fullName = fullNameController.value.text;
    var firstName = fullName.substring(0, fullName.indexOf(" "));
    var lastName = fullName.substring(fullName.indexOf(" ") + 1);

    updating(true);
    await FireStoreServices.updateUseDate({
      'firstName':firstName,
      'lastName':lastName
    }).then((value){
      customSnackBar("Profile Update","Information updated successfully");
      updating(false);
    }).onError((error, stackTrace){
      updating(false);
      MyAlert.showToast(error.toString());
    });
  }

  isPasswordEmpty(){
    if(currentPasswordController.value.text.isEmpty||newPasswordController.value.text.isEmpty||confirmNewPasswordController.value.text.isEmpty){
      MyAlert.showToast("Please fill fields");
      return true;
    }else{
      return false;
    }
  } isPasswordMatches(){
    if(newPasswordController.value.text==confirmNewPasswordController.value.text){
      return true;
    }else{
      MyAlert.showToast("Password doesn't matches");
      return false;
    }
  }

  changePassword() async {
    if(!isPasswordEmpty()){
      if(isPasswordMatches()) {
        updating(true);
        await AuthServices.changePassword(
          newPassword: newPasswordController.value.text,
          currentPassword: currentPasswordController.value.text
        ).then((value){
          if(value==true) {
            customSnackBar("Change Password", "Password changed successfully.");
            resetFields();
          }
          updating(false);
        }).onError((error, stackTrace){
          MyAlert.showToast(error.toString());
          updating(false);
        });
      }
    }
  }

  resetFields(){
    newPasswordController.value.text='';
    currentPasswordController.value.text='';
    confirmNewPasswordController.value.text='';

  }
}
