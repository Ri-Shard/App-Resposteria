import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{

  static  AddressController instance = Get.find();
  
  String usersCollection = "users";

  TextEditingController barrio = TextEditingController(); 
  TextEditingController address = TextEditingController(); 
  TextEditingController city = TextEditingController(); 
  TextEditingController phone = TextEditingController(); 

  RxList<AddressModel> addresslist = RxList<AddressModel>([]);
  AddressModel addressModel = AddressModel();

  @override
  void onInit() {
    super.onInit();
    checkAddress();    
  }

    _clearControllers() {

    address.clear();
    city.clear();
    phone.clear();
    barrio.clear();
  }

  List<AddressModel> checkAddress(){
    addresslist.bindStream(getAddress(auth.currentUser!.uid.toString()));
    return addresslist;
  }
  Stream<List<AddressModel>> getAddress(String userUid) =>
    firebaseFirestore.collection(usersCollection).doc(userUid).collection("address").snapshots().map((event) => 
    event.docs.map((e) => AddressModel.fromMap(e.data())).toList());
  
  addAddressToFirestore(String userUid){
    String now = DateTime.now().microsecond.toString();
    firebaseFirestore.collection(usersCollection).doc(userUid).collection("address").doc(now).set({
      "name": authController.myuser.name,
      "address": address.text.trim(),
      "city": city.text.trim(),
      "phone": phone.text.trim(),
      "barrio": barrio.text.trim(),
      "date": now
    });
    _clearControllers();
  }
  deleteAddress(String? date){
    firebaseFirestore.collection(usersCollection).doc(authController.myuser.uid).collection("address").doc(date).delete();
  }
}