import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy_rx/models/Auth/pharmacy_model.dart';

import 'firebase_exceptions.dart';

class FireStoreServices {

 static var pharmacyCollection=FirebaseFirestore.instance.collection('Pharmacies');

  static Future<PharmacyModel> getPharmacy() async {
    try {
      String pharmacyId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot documentSnapshot = await pharmacyCollection.doc(pharmacyId)
          .get();
      PharmacyModel _pharmacyModel = PharmacyModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
      return _pharmacyModel;
    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }

  static Future uploadPharmacyData(PharmacyModel pharmacyModel) async {
    try {
      await pharmacyCollection.doc(pharmacyModel.pharmacyId).set(pharmacyModel.toJson());
      return true;
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }
  static Future updateUseDate(var map) async {
    try {
      String currentpharmacyId=FirebaseAuth.instance.currentUser!.uid;
      await pharmacyCollection.doc(currentpharmacyId).update(map);
      return true;
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }
 static ispharmacyNameExist(String pharmacyName) async {
    QuerySnapshot queryDocumentSnapshot=await pharmacyCollection.where('pharmacyName',isEqualTo: pharmacyName).get();
    if(queryDocumentSnapshot.size>0){
      return true;
    }
    return false;
  }
}
