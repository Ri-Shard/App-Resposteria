  
import 'dart:async';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/delivery_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  static DeliveryController instance = Get.find();

  RxList<DeliveryModel> deliverys = RxList<DeliveryModel>([]);
  TextEditingController name = TextEditingController();
  TextEditingController placa = TextEditingController();
  TextEditingController vehiculo = TextEditingController();
  TextEditingController cedula = TextEditingController();
  TextEditingController email = TextEditingController();
  String collection = "delivery";
  @override
  onReady() {
    super.onReady();
    deliverys.bindStream(getAllDeliverys());
  }

  Stream<List<DeliveryModel>> getAllDeliverys() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => DeliveryModel.fromMap(item.data())).toList());

   addDeliveryToFirestore(String uid){
    firebaseFirestore.collection(collection).doc(uid).set({
      "name": name.text.trim(),
      "placa": placa.text.replaceAll('-', '').trim(),
      "vehiculo": vehiculo.text.trim(),
      "cedula": cedula.text.trim(),
      "email": email.text.trim(),
      "estado": "ACTIVO",
      "id": uid
          });
          clearControllers();
          register();
  }
    void register() async {
    try{    
      await auth.createUserWithEmailAndPassword(email: email.text.trim(), password: cedula.text.trim())
      .then((result){
       String _userUid = result.user!.uid;
       addDeliveryToFirestore(_userUid);
        Get.snackbar("Registro Correcto", "Se ha registrado correctamenta el Domiciliario");
        clearControllers();
      });
    }catch (e){
      debugPrint(e.hashCode.toString());
      if (e.hashCode.toInt() == 34618382) {
        Get.snackbar("Registro Incorrecto", "Email registrado Con otra Cuenta");
      }
    }
  }

      void clearControllers() {
        name.clear();
        cedula.clear();
        email.clear();
        placa.clear();
        vehiculo.clear();
       } 

      deleteDelivery(String iddelivery){
        try{
            firebaseFirestore.collection(collection).doc(iddelivery).delete();
        }catch (e){

        }
      }
}
