import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy_rx/models/Auth/pharmacy_model.dart';
import 'package:pharmacy_rx/utils/alert.dart';

import 'firebase_exceptions.dart';

final PharmacyModel _pharmacyModel = PharmacyModel();

class AuthServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;

// ---------------------------------> Sign Up
  static Future<bool> signUp(String? email, String? password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      final User user = result.user!;
      _pharmacyModel.pharmacyId = user.uid;
      //-------------->print('if')
      ('created Successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        MyAlert.showToast('weak Password');
        return false;
      } else if (e.code == 'email-already-in-use') {
        MyAlert.showToast('Email already Exists');
        return false;
      } else if (e.code == 'invalid-email') {
        MyAlert.showToast('Please enter valid email address');
        return false;
      } else {
        MyAlert.showToast(e.toString());
        return false;
      }
    } catch (e) {
      (e.toString());
      MyAlert.showToast(e.toString());
      return false;
    }
  }

// ---------------------------------> Login
  static Future<bool> login(String? email, String? password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      final User user = result.user!;
      _pharmacyModel.pharmacyId = user.uid;
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        MyAlert.showToast('User not found');
        return false;
      } else if (e.code == 'wrong-password') {
        MyAlert.showToast('Wrong password');
        return false;
      } else if (e.code == 'invalid-email') {
        MyAlert.showToast('Invalid Email');
        return false;
      } else {
        MyAlert.showToast(e.toString());
        return false;
      }
    } catch (e) {
      ('Error is ${e.toString()}');
      MyAlert.showToast(e.toString());
      return false;
    }
  }

  

// ---------------------------------> Reset Password
  static Future<bool> resetPassword(String _email) async {
    try {
      await auth.sendPasswordResetEmail(email: _email);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MyAlert.showToast('No user found for that email.');
        return false;
      } else {
        MyAlert.showToast(e.toString());
        return false;
      }
    } catch (e) {
      print("Error is ${e.toString()}");
      MyAlert.showToast(e.toString());
      return false;
    }
  }

  static logout() async => await auth.signOut();

 static Future changePassword({required String newPassword,required String currentPassword}) async {

      try {
        String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
        bool authenticated =await login(currentUserEmail,currentPassword);
        if (authenticated) {
          var user = auth.currentUser;
          await user!.updatePassword(newPassword);
          return true;
        }
        return false;
      } on FirebaseException catch(firebase){
       throw FirebaseExceptions(firebase);
      }
      catch(e){
        throw e.toString();
      }
  }


}
