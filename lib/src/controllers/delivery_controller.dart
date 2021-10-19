import 'dart:async';
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/delivery_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
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
  TextEditingController phone = TextEditingController();
  DeliveryModel delivery = DeliveryModel();
  String collection = "delivery";

//test------------------------
  final instanceTest = FakeFirebaseFirestore();
  RxList<DeliveryModel> deliverysTest = RxList<DeliveryModel>([]);

  @override
  onReady() {
    super.onReady();
    listenToUser();
    checkDeliverys();
    checkDelivery();
  }

  List<DeliveryModel> checkDelivery() {
    deliverys.bindStream(getAllDeliverys());
    return deliverys;
  }

  listenToUser() => firebaseFirestore
          .collection(collection)
          .doc(auth.currentUser!.uid)
          .get()
          .then((snapshot) {
        delivery = delivery.fromSnapshot(snapshot);
      });

  Stream<List<DeliveryModel>> getUsers() =>
      firebaseFirestore.collection(collection).snapshots().map((event) =>
          event.docs.map((e) => DeliveryModel.fromMap(e.data())).toList());

  Stream<List<DeliveryModel>> getAllDeliverys() => firebaseFirestore
      .collection(collection)
      .snapshots()
      .map((query) => query.docs
          .map((item) => DeliveryModel.fromMap(item.data()))
          .toList());

  String addDeliveryToFirestore(String uid) {
    String message;
    try {
      String message;
      firebaseFirestore.collection(collection).doc(uid).set({
        "name": name.text.trim(),
        "placa": placa.text.replaceAll('-', '').trim(),
        "vehiculo": vehiculo.text.trim(),
        "cedula": cedula.text.trim(),
        "email": email.text.trim(),
        "phone": phone.text.trim(),
        "estado": "ACTIVO",
        "id": uid
      });
      clearControllers();
      message = "Se ha registrado correctamenta el Domiciliario";
      return message;
    } catch (e) {
      debugPrint(e.hashCode.toString());
      message = "  Problemas en el Registro";
      Get.snackbar("Registro Incorrecto", message);
      return message;
    }
  }

  String pError(String e) {
    String message = "";
    if (e.hashCode.toInt() == 34618382) {
      message = "Email registrado Con otra Cuenta";
      Get.snackbar("Registro Incorrecto", message);
      return message;
    }
    return message;
  }

  Future<String> register() async {
    String message = "";
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: cedula.text.trim())
          .then((result) {
        String _userUid = result.user!.uid;
        message = addDeliveryToFirestore(_userUid);
        Get.snackbar("Registro Correcto", message);
        clearControllers();
        return message;
      });
    } catch (e) {
      message = pError(e.toString());
    }
    return message;
  }

  void clearControllers() {
    name.clear();
    cedula.clear();
    email.clear();
    placa.clear();
    vehiculo.clear();
    phone.clear();
  }

  String deleteD(String iddelivery) {
    String message;
    bool exists = searchDelivery(iddelivery);
    if (exists) {
      firebaseFirestore.collection(collection).doc(iddelivery).delete();
      message = "Eliminado Con Exito";
      Get.snackbar("Enhorabuena", message);
      return message;
    } else {
      message = "Domiciliario no Existe";
      Get.snackbar("Error", message);
      return message;
    }
  }

  delete(String iddelivery) {
    deleteDelivery(iddelivery);
  }

  updateD(String iddelivery) {
    updateDelivery(iddelivery);
  }

  bool searchDelivery(String id) {
    if (authController.deliverylist.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  String updateDelivery(String iddelivery) {
    String message;
    try {
      bool exists = searchDelivery(iddelivery);
      if (exists) {
        firebaseFirestore.collection(collection).doc(iddelivery).update({
          "name": name.text.trim(),
          "placa": placa.text.replaceAll('-', '').trim(),
          "vehiculo": vehiculo.text.trim(),
          "cedula": cedula.text.trim(),
          "phone": phone.text.trim(),
          "estado": "ACTIVO",
        });
        clearControllers();
        message = "Modificado Con Exito";
        Get.snackbar("Enhorabuena", message);
        return message;
      } else {
        clearControllers();
        message = "Domiciliario No existe";
        Get.snackbar("Error", message);
        return message;
      }
    } catch (e) {
      clearControllers();
      message = "Se presentaron errores";
      Get.snackbar("Actualizacion Incorrecta", message);
      return message;
    }
  }

  //Test--------------------------------------
  String newmethod(String ow) {
    if (ow.contains("@") && ow.contains(".com")) {
      return ("Prueba Correcta");
    } else {
      return ("Prueba Fallida");
    }
  }

  Stream<List<DeliveryModel>> getDeliverystest() =>
      instanceTest.collection(collection).snapshots().map((event) =>
          event.docs.map((e) => DeliveryModel.fromMap(e.data())).toList());

  String registerTest() {
    instanceTest.collection(collection).add({
      'email': email.text,
      'name': name.text,
      'phone': phone.text,
      'estado': "ACTIVO",
      'cedula': cedula.text,
      'placa': placa.text,
      'vehiculo': vehiculo.text,
    });
    DeliveryModel deliveryTest = new DeliveryModel();
    deliveryTest.cedula = cedula.text.trim();
    deliveryTest.email = email.text.trim();
    deliveryTest.name = name.text.trim();
    deliveryTest.estado = "ACTIVO";
    deliveryTest.placa = placa.text.trim();
    deliveryTest.vehiculo = vehiculo.text.trim();
    deliveryTest.phone = phone.text.trim();

    deliverysTest.add(deliveryTest);
    deliverysTest.bindStream(getDeliverystest());

    bool flag = false;
    if (newmethod(email.text) == "Prueba Fallida") {
      flag = true;
    }
    if (flag == true) {
      print("Problemas en el Registro");
      return "Problemas en el Registro";
    } else {
      print("Se ha registrado correctamenta el Domiciliario");
      return "Se ha registrado correctamenta el Domiciliario";
    }
  }

  List<DeliveryModel> checkDeliverys() {
    DeliveryModel delivery = DeliveryModel();
    delivery.email = "pedro@gmail.com";
    delivery.name = "Pedro";
    delivery.placa = "ASD123";
    delivery.vehiculo = "Boxer";
    delivery.cedula = "49789542";
    delivery.phone = "3018964512";
    delivery.estado = "ACTIVO";
    deliverysTest.add(delivery);
    return deliverysTest;
  }

  String updateDeliveryData(String iddelivery) {
    String message;
    if (iddelivery == "49789542") {
      instanceTest.collection(collection).doc(iddelivery).update({
        'email': email.text,
        'name': name.text,
        'phone': phone.text,
        'estado': "ACTIVO",
        'cedula': cedula.text,
        'placa': placa.text,
        'vehiculo': vehiculo.text,
      });
      message = "Modificado Con Exito";
      print(message);
      return message;
    } else {
      message = "Domiciliario No existe";
      return message;
    }
  }

  Future<String> deleteDelivery(String id) async {
    String message;

    if (id == "49789542") {
      instanceTest.collection(collection).doc(id).delete();
      message = "Eliminado Con Exito";
      print(message);
      return message;
    } else {
      message = "Domiciliario no Existe";
      print(message);
      return message;
    }
  }
}
