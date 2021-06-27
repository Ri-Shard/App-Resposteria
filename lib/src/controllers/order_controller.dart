import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{

  static  OrderController instance = Get.find();
  
  String usersCollection = "users";

  @override
  void onInit() {
    super.onInit();

        listenToOrder();
    
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
    firebaseFirestore.collection(usersCollection).doc(userUid).collection("pedidos").doc(userUid+nowe).set({
      "uid": userUid,
      "name": authController.myuser.name,
      "address": authController.addressModel.address,
      "date": now,
      "status": "EN PROCESO",
      "cart": FieldValue.arrayUnion(authController.myuser.cartItemsToJson())
    });

    firebaseFirestore.collection(usersCollection).doc('JfbPPdFfKlbqdFj4vF4Vy3FdGs93').collection("pedidos").doc(userUid+nowe).set({
      "uid": userUid,
      "name": authController.myuser.name,
      "address": authController.addressModel.address,
      "date": now,
      "status": "EN PROCESO",
      "cart": FieldValue.arrayUnion(authController.myuser.cartItemsToJson())
    });

  }

       listenToOrder() => firebaseFirestore
      .collection("usersCollection")
      .doc(auth.currentUser!.uid)
      .collection("pedidos")
      .snapshots();

    userindex() {
    authController.userlist.forEach((element) {
    firebaseFirestore.collection(usersCollection).doc(element.uid).collection("pedidos").snapshots().map((event) => 
    event.docs.map((e) => OrderModel.fromMap(e.data())).toList());    
    });
  }

}