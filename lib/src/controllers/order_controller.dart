import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  String usersCollection = "orders";
  OrderModel ordermodel = OrderModel();
  RxList<OrderModel> orderlist = RxList<OrderModel>([]);
  RxList<OrderModel> orderlistTest = RxList<OrderModel>([]);
    RxList<CartItemModel> cartlistOrder = RxList<CartItemModel>([]);

  @override
  void onReady() {
    super.onReady();
    checkOrder();
  }

  String addOrderToFirestore(String userUid) {
    String message;
    try {
    String dia = DateTime.now().day.toString();
    String mes = DateTime.now().month.toString();
    String year = DateTime.now().year.toString();
    String hour = DateTime.now().hour.toString();
    String min = DateTime.now().minute.toString();
    String second = DateTime.now().second.toString();
    String now =
        dia + "/" + mes + "/" + year + "/" + hour + "/" + min + "/" + second;
    String nowe = dia + mes + year + hour + min + second;
    firebaseFirestore.collection(usersCollection).doc(nowe).set({
      "uid": userUid,
      "name": authController.myuser.name,
      "address": addressController.addressModel.address,
      "date": now,
      "dat": nowe,
      "delivery": "",
      "deliveryname": "",
      "clientrating": 0.toString(),
      "status": "EN PROCESO",
      "total":
          cartController.cartTotalPrice().toString(),
    });
    cartController.cartlist.forEach((element) {
      firebaseFirestore  
        .collection(usersCollection)
        .doc(nowe)
        .collection("cart")
        .doc(element.productId)
        .set(element.toMap(element));
    });
        
        
            
    message = "Orden Guardada con exito";
    Get.snackbar("Enhorabuena", message);
    return message;
    } catch (e) {
      message = "Se produjeron errores al guardar la orden";
       Get.snackbar("Error", message);
       return message;
    }
  }

  listenToOrder() => firebaseFirestore.collection(usersCollection).snapshots();

  List<OrderModel> checkOrder() {
    orderlist.bindStream(getOrders());
    return orderlist;
  }
  List<OrderModel> checkOrders() {
    OrderModel order = new OrderModel();
    orderlistTest.add(order);
    return orderlistTest;
  }

  Stream<List<OrderModel>> getOrders() =>
      firebaseFirestore.collection(usersCollection).snapshots().map((event) =>
          event.docs.map((e) => OrderModel.fromMap(e.data())).toList());

  Stream<List<CartItemModel>> getCart(String id) => firebaseFirestore
      .collection(usersCollection)
      .doc(id)
      .collection("cart")
      .snapshots()
      .map((event) => event.docs.map((e) => CartItemModel.fromMap(e.data())).toList());

  Future <List<CartItemModel>> checkCart(String id) async{
    cartlistOrder.bindStream(getCart(id));
    return cartlistOrder;
  }


  updateDeliveryOrder(OrderModel order, String delivery, String deliveryname) {
    deleteOrde(order.dat.toString());
    firebaseFirestore.collection(usersCollection).doc(order.dat).set({
      "uid": order.uid,
      "name": order.name,
      "address": order.address,
      "date": order.date,
      "dat": order.dat,
      "status": "ENTREGADO",
      "delivery": delivery,
      "deliveryname": deliveryname,
      "total": order.total,
      "clientrating": 0.toString(),
    });
    cartController.cartlist.forEach((element) {
      firebaseFirestore  
        .collection(usersCollection)
        .doc(order.dat)
        .collection("cart")
        .doc(element.productId)
        .set(element.toMap(element));
    });
  }

  String updateUserOrde(OrderModel order, String status) {
    String message;
    try {    
    deleteOrde(order.dat.toString());
    firebaseFirestore.collection(usersCollection).doc(order.dat).set({
      "uid": order.uid,
      "name": order.name,
      "address": order.address,
      "date": order.date,
      "dat": order.dat,
      "status": status,
      "delivery": order.delivery,
      "deliveryname": order.deliveryname,
      "clientrating": order.clientrating.toString(),
      "total": order.total,
    });
        cartController.cartlist.forEach((element) {
      firebaseFirestore  
        .collection(usersCollection)
        .doc(order.dat)
        .collection("cart")
        .doc(element.productId)
        .set(element.toMap(element));
    });
    message = "Orden modificada con exito";
    Get.snackbar("Enhorabuena", message);
    return message;
    } catch (e) {
      message ="Se produjeron errores al modificar la orden";
       Get.snackbar("Error", message);
       return message;
    }
  }

  updateOrder(OrderModel order) {
    deleteOrde(order.dat.toString());
    firebaseFirestore.collection(usersCollection).doc(order.dat).set({
      "uid": order.uid,
      "name": order.name,
      "address": order.address,
      "date": order.date,
      "dat": order.dat,
      "delivery": "",
      "deliveryname": "",
      "clientrating": 0.toString(),
      "status": "PEDIDO LISTO",
      "total": order.total,
    });
        cartController.cartlist.forEach((element) {
      firebaseFirestore  
        .collection(usersCollection)
        .doc(order.dat)
        .collection("cart")
        .doc(element.productId)
        .set(element.toMap(element));
    });
  }

  String deleteOrde(String id) {
    String message;
    try {
    firebaseFirestore.collection(usersCollection).doc(id).delete();
    message = "Orden Borrada con exito";
     Get.snackbar("Enhorabuena", message);
     return message;
    } catch (e) {
      message = "Se produjeron errores al eliminar la orden";
      Get.snackbar("Error", message);
      return message;
    }
  }

     String registerTest(){
      bool flag = false;
       if(flag == true){
        print("Orden Guardada con exito");
        return "Orden Guardada con exito";
       }else{
        print("Se produjeron errores al guardar la orden");
       return "Se produjeron errores al guardar la orden";
       }
    }
    Future<String> deleteOrder(String id) async {
    String message;
      bool e = false;
      if (e == true) {
      message = "Orden Borrada con exito";
      print(message);
      return message;
      } else {
      message= "Se produjeron errores al eliminar la orden";
        print(message);
        return message;
      }
  }
    String updateUserOrder(OrderModel order, String status) {
    String message;
      bool exists = false;
      if (exists == true) {
        message = "Orden modificada con exito";
        print(message);
        return message;
      } else {
        message = "Se produjeron errores al modificar la orden";
        return message;
      }
  }
}
