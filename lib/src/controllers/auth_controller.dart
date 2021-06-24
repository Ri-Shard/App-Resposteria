import 'package:appreposteria/src/constants/app_constants.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/address_model.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:appreposteria/src/ui/admin/admin_home_screen.dart';
import 'package:appreposteria/src/ui/auth/auth_screen.dart';
import 'package:appreposteria/src/ui/common/splash_screen.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AuthController extends GetxController {
  static  AuthController instance = Get.find();

  RxBool isLoggedIn = false.obs;
  RxBool isAdmin = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  MyUser myuser = MyUser();
  OrderModel order = OrderModel();
 RxList<AddressModel> addresslist = RxList<AddressModel>([]);
AddressModel addressModel = AddressModel();

 //controllers Address
TextEditingController barrio = TextEditingController(); 
TextEditingController address = TextEditingController(); 
TextEditingController city = TextEditingController(); 
TextEditingController phone = TextEditingController(); 

  @override
  void onInit() {
    super.onInit();
    if(auth.currentUser != null ){
        listenToUser();
        listenToOrder();
        checkAddress();
    }
  }

  @override
  void onReady() {
    super.onReady();
    _setInitialScreen(auth.currentUser);
  }
  _setInitialScreen(User? user) async {
    if(user == null){  
    await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => SplashScreen());
      Get.offAll(() => AuthenticScreen());
    }else if (auth.currentUser!.uid != 'JfbPPdFfKlbqdFj4vF4Vy3FdGs93'){
      Get.offAll(() =>HomePage());
    }else{
      Get.offAll(() => AdminHomePage());
    }
  }

  void logIn() async {
    try{
      await auth
      .signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim())
      .then((result) {
        if(result.user!.uid == 'JfbPPdFfKlbqdFj4vF4Vy3FdGs93'){
          Get.offAll(() => AdminHomePage());
        }else{
          Get.offAll(() =>HomePage());
        }
        listenToUser();
        _clearControllers();
      });
    }catch(e){
      debugPrint(e.toString());
      Get.snackbar("LogIn Fallido", "Intentelo Mas Tarde");
    }
  }

  void register() async {
    try{
      await auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim())
      .then((result){
        String _userUid = result.user!.uid;
        _addUserToFirestore(_userUid);
        _clearControllers();
      });
    }catch (e){
      debugPrint(e.toString());
      Get.snackbar("Registro Fallido", "Intentelo Mas Tarde");
    }
  }
    void signOut() async {
    auth.signOut();
    Get.offAll(() => AuthenticScreen());

  }

  _addUserToFirestore(String userUid){
    firebaseFirestore.collection(usersCollection).doc(userUid).set({
      "name": name.text.trim(),
      "uid": userUid,
      "email": email.text.trim(),
      "cart": []
    });
  }
    _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
    //
    address.clear();
    city.clear();
    phone.clear();
    barrio.clear();
  }
    updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(auth.currentUser!.uid)
        .update(data);
  }
   listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(auth.currentUser!.uid)
      .get()
      .then((snapshot) {
      myuser = myuser.fromSnapshot(snapshot);
      }); 

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
      "name": myuser.name,
      "address": address.text.trim(),
      "city": city.text.trim(),
      "phone": phone.text.trim(),
      "barrio": barrio.text.trim(),
      "date": now
    });
    _clearControllers();
  }
  deleteAddress(String? date){
    firebaseFirestore.collection(usersCollection).doc(myuser.uid).collection("address").doc(date).delete();
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
    firebaseFirestore.collection("pedidos").doc(userUid).collection(userUid).doc(userUid+nowe).set({
      "uid": userUid,
      "name": myuser.name,
      "address": addressModel.address,
      "date": now,
      "cart": FieldValue.arrayUnion(myuser.cartItemsToJson())
    });
    _clearControllers();
  }

       listenToOrder() => firebaseFirestore
      .collection("pedidos")
      .doc(auth.currentUser!.uid)
      .collection(auth.currentUser!.uid)
      .snapshots();

}
