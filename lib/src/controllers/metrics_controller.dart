import 'dart:collection';

import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/model/delivery_model.dart';
import 'package:appreposteria/src/model/metrics_model.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MetricsController extends GetxController {
  static MetricsController instance = Get.find();

  String collection = "metrics";
  RxList<MetricsModel> metricslist = RxList<MetricsModel>([]);
  MetricsModel metricsmodel = MetricsModel();
  double ganancias = 0;

@override
  void onInit() {
    super.onInit();
    orderController.onInit();
    orderController.onReady();
    deliveryController.onReady();
  }
  @override
  void onReady() {
    super.onReady();
    checkMetrics();
  }

  List<MetricsModel> checkMetrics() {
    metricslist.bindStream(getMetrics());
    return metricslist;
  }

  Stream<List<MetricsModel>> getMetrics() =>
      firebaseFirestore.collection(collection).snapshots().map((event) =>
          event.docs.map((e) => MetricsModel.fromMap(e.data())).toList());

  String addMetricsToFirestore(String userUid) {
    String message;
    try {
      firebaseFirestore.collection(collection).doc("data").set({});
      message = "Guardado correctamente";
      Get.snackbar("Enhorabuena", message);
      return message;
    } catch (e) {
      message = "Se han producido errores al guardar";
      Get.snackbar("Error", message);
      return message;
    }
  }

  String calcularGanancias() {
    ganancias = 0;
    orderController.orderlist.forEach((element) {
      double myDouble = 0;
      if (element.status == "ENTREGADO"||element.status == "RECIBIDO POR USUARIO") {
        myDouble = double.parse(element.total.toString());
        ganancias = ganancias + myDouble;
      }
    });
    return ganancias.toString();
  }

  String calcularGananciasLast7days() {
    String dateorder = "";
    double myDouble = 0;
    ganancias = 0;
    orderController.orderlist.forEach((element) {
      if (element.status == "ENTREGADO"||element.status == "RECIBIDO POR USUARIO") {
        dateorder = element.datetime.toString();
        var parsedDate = DateTime.parse(dateorder);
        Duration _diastotales = DateTime.now().difference(parsedDate);
        if (int.parse(_diastotales.inDays.toString()) < 7) {
          myDouble = double.parse(element.total.toString());
          ganancias = ganancias + myDouble;
        }
      }
    });
    return ganancias.toString();
  }

  Map clienteMasCompra() {
    int cont = 0;
    List<int> aux = [];
    List<String> orderlistUID = [];
    orderController.orderlist.forEach((element) {
      orderlistUID.add(element.uid.toString());
    });
    int long = orderlistUID.length;

    Map contador = {};
    for (var i = 0; i < long; i++) {
      cont = 0;
      for (var j = i; j < long; j++) {
        if (!contador.keys.contains(orderlistUID[i])) {
          if (orderlistUID[i] == orderlistUID[j]) {
            aux.add(j);
          }
        }
      }
      if (!contador.keys.contains(orderlistUID[i])) {
        contador[orderlistUID[aux.first]] = {
          "id": orderlistUID[aux.first],
          "cont": aux.length
        };
      }
      aux.clear();
    }
    //sort map
    var sortedKeys = contador.keys.toList(growable: false)
      ..sort((k2, k1) => contador[k1]['cont'].compareTo(contador[k2]['cont']));
    LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => contador[k]);
    return sortedMap.values.first;
  }
  Map domiMasVende() {
    int cont = 0;
    List<int> aux = [];
    List<String> deliverylistUID = [];
    deliveryController.deliverys.forEach((element) {
      deliverylistUID.add(element.id.toString());
    });
    int long = deliverylistUID.length;

    Map contador = {};
    for (var i = 0; i < long; i++) {
      cont = 0;
      for (var j = i; j < long; j++) {
        if (!contador.keys.contains(deliverylistUID[i])) {
          if (deliverylistUID[i] == deliverylistUID[j]) {
            aux.add(j);
          }
        }
      }
      if (!contador.keys.contains(deliverylistUID[i])) {
        contador[deliverylistUID[aux.first]] = {
          "id": deliverylistUID[aux.first],
          "cont": aux.length
        };
      }
      aux.clear();
    }
    //sort map
    var sortedKeys = contador.keys.toList(growable: false)
      ..sort((k2, k1) => contador[k1]['cont'].compareTo(contador[k2]['cont']));
    LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => contador[k]);
    return sortedMap.values.first;
  }

DeliveryModel domiMasvendeNom(){
  DeliveryModel user = DeliveryModel();
    deliveryController.deliverys.forEach((element) {
      if(element.id == domiMasVende()['id']){
        user = element;
      }
    });
   return user;
}

MyUser clientemascompraNom(){
MyUser user = MyUser();
    authController.userlist.forEach((element) {
      if(element.uid == clienteMasCompra()['id']){
        user = element;
      }
    });
   return user;
}

  void cantProductosVendidos() {
    int total = 0;
    List<String> cant = [];
    orderController.orderlist.forEach((element) {
      if (element.status == "ENTREGADO"||element.status == "RECIBIDO POR USUARIO") {
      orderController.checkCart(element.dat.toString());
      print(orderController.cartlistOrder.map((e) => e.quantity.toString()).toString());
      }
      orderController.cartlistOrder.clear();
    });
  }
}
