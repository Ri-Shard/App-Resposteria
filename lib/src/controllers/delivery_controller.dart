  
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
  String collection = "delivery";

  @override
  onReady() {
    super.onReady();
    deliverys.bindStream(getAllDeliverys());
  }

  Stream<List<DeliveryModel>> getAllDeliverys() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => DeliveryModel.fromMap(item.data())).toList());

   addDeliveryToFirestore(){
    String doc = firebaseFirestore.collection(collection).doc().id.toString();
    firebaseFirestore.collection(collection).doc(doc).set({
      "name": name.text.trim(),
      "placa": placa.text.trim(),
      "vehiculo": vehiculo.text.trim(),
      "estado": "ACTIVO",
      "id": doc
          });
          _clearControllers();
  }

      _clearControllers() {
        name.clear();
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
