import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{

  static  OrderController instance = Get.find();
  
  String usersCollection = "users";
  OrderModel ordermodel = OrderModel();
  RxList<OrderModel> orderlist = RxList<OrderModel>([]);
      @override
  void onReady() {
    super.onReady();
    checkAddress();
  }

  addOrderToFirestore(String userUid){
    String dia = DateTime.now().day.toString();
    String mes = DateTime.now().month.toString();
    String year = DateTime.now().year.toString();
    String hour = DateTime.now().hour.toString();
    String min = DateTime.now().minute.toString();
    String second = DateTime.now().second.toString();
    String now  = dia+"/"+mes+"/"+year+"/"+hour+"/"+min+"/"+second;
    String nowe  = dia+mes+year+hour+min+second;
    firebaseFirestore.collection(usersCollection).doc(userUid).collection("pedidos").doc(nowe).set({
      "uid": userUid,
      "name": authController.myuser.name,
      "address":addressController.addressModel.address,
      "date": now,
      "dat": nowe,
      "status": "EN PROCESO",
      "total": cartController.changeCartTotalPrice(authController.myuser).toString(),
      "cart": FieldValue.arrayUnion(authController.myuser.cartItemsToJson())
    });

    firebaseFirestore.collection(usersCollection).doc('JfbPPdFfKlbqdFj4vF4Vy3FdGs93').collection("pedidos").doc(nowe).set({
      "uid": userUid,
      "name": authController.myuser.name,
      "address": addressController.addressModel.address,
      "date": now,
      "dat": nowe,
      "status": "EN PROCESO",
      "total": cartController.changeCartTotalPrice(authController.myuser).toString(),
      "cart": FieldValue.arrayUnion(authController.myuser.cartItemsToJson())
    });

  }

       listenToOrder() => firebaseFirestore
      .collection("usersCollection")
      .doc(authController.myuser.uid)
      .collection("pedidos")
      .snapshots();

  List<OrderModel> checkAddress(){
    orderlist.bindStream(getAddress(authController.myuser.uid.toString()));
    return orderlist;
  }
  Stream<List<OrderModel>> getAddress(String userUid) =>
    firebaseFirestore.collection(usersCollection).doc(userUid).collection("pedidos").snapshots().map((event) => 
    event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
  
  
  updateOrder(OrderModel order){

    deleteOrder(order);
    firebaseFirestore.collection(usersCollection).doc(order.uid).collection("pedidos").doc(order.dat).set({
      "uid": order.uid,
      "name": authController.myuser.name,
      "address":addressController.addressModel.address,
      "date": order.date,
      "dat": order.dat,
      "status": "ENTREGADO",
      "total": order.total,
      "cart": FieldValue.arrayUnion(order.cartItemsToJson())
    });

    firebaseFirestore.collection(usersCollection).doc('JfbPPdFfKlbqdFj4vF4Vy3FdGs93').collection("pedidos").doc(order.dat).set({
      "uid": order.uid,
      "name": authController.myuser.name,
      "address": addressController.addressModel.address,
      "date": order.date,
      "dat": order.dat,
      "status": "ENTREGADO",
      "total": order.total,
      "cart": FieldValue.arrayUnion(order.cartItemsToJson())
    });
  }
  deleteOrder(OrderModel order){
  firebaseFirestore.collection(usersCollection).doc(authController.myuser.uid).collection("pedidos").doc(order.dat).delete();
  firebaseFirestore.collection(usersCollection).doc('JfbPPdFfKlbqdFj4vF4Vy3FdGs93').collection("pedidos").doc(order.dat).delete();
  }

}