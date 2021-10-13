import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddressController extends GetxController{

  static  AddressController instance = Get.find();
  
  String usersCollection = "users";

  TextEditingController barrio = TextEditingController(); 
  TextEditingController address = TextEditingController(); 
  TextEditingController city = TextEditingController(); 
  TextEditingController name = TextEditingController(); 

  RxList<AddressModel> addresslist = RxList<AddressModel>([]);
  AddressModel addressModel = AddressModel();

    @override
  void onReady() {
    super.onReady();
    checkAddres();
  }
  

    _clearControllers() {

    address.clear();
    city.clear();
    barrio.clear();
  }

  List<AddressModel> checkAddres(){
    addresslist.bindStream(getAddress(authController.myuser.uid.toString()));
    return addresslist;
  }
  List<AddressModel> checkAddress(){
    AddressModel model = new AddressModel();
    addresslist.add(model);
    return addresslist;
  }
  Stream<List<AddressModel>> getAddress(String userUid) =>
    firebaseFirestore.collection(usersCollection).doc(userUid).collection("address").snapshots().map((event) => 
    event.docs.map((e) => AddressModel.fromMap(e.data())).toList());
  
  String addAddressToFirestore(String userUid){
    String message;
    try {      
    String now = DateTime.now().microsecond.toString();
    firebaseFirestore.collection(usersCollection).doc(userUid).collection("address").doc(now).set({
      "name": authController.myuser.name,
      "address": address.text.trim(),
      "city": city.text.trim(),
      "barrio": barrio.text.trim(),
      "id": now
    });
    _clearControllers();
    message = "Guardado correctamente";
      Get.snackbar("Enhorabuena", message);        
      return message;
    } catch (e) {
      message = "Se han producido errores al guardar";
      Get.snackbar("Error", message);        
      return message;
    }
  }

    String deleteAddres(String? id) {
      String message;
      bool exists = searchAddress(id);
      if(exists){
    firebaseFirestore.collection(usersCollection).doc(authController.myuser.uid)
    .collection("address").doc(id).delete();
    message = "Eliminado Con Exito";
      Get.snackbar("Enhorabuena", message);
      return message;
      }else{
        message ="Direccion  no Existe";
      Get.snackbar("Error", message);
      return message;        
      }    
  }
      String deleteAddress(String id) {
    String message;
      bool e = false;
      if (e == true) {
      message = "Eliminado Con Exito";
      print(message);
      return message;
      } else {
      message= "Direccion  no Existe";
        print(message);
        return message;
      }
  }
       String registerTest(String id){
      bool flag = false;
       if(flag == true){
        print("Guardado correctamente");
        return "Guardado correctamente";
       }else{
        print("Se han producido errores al guardar");
       return "Se han producido errores al guardar";
       }
    }
    bool searchAddress(String? id) {
      AddressModel? element ;
    if (addresslist.contains(element!.id)) {
      return true;
    } else {
      return false;
    }
  }

}