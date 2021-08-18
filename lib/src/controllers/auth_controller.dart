import 'package:appreposteria/src/constants/app_constants.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:appreposteria/src/other/bottom_bar_Admin.dart';
import 'package:appreposteria/src/other/bottom_bar_User.dart';
import 'package:appreposteria/src/ui/auth/auth_screen.dart';
import 'package:appreposteria/src/ui/common/splash_screen.dart';
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
  RxList<MyUser> userlist = RxList<MyUser>([]);

  @override
  void onInit() {
    super.onInit();
    if(auth.currentUser != null ){
        listenToUser();        
        checkUsers();
    }
  }

  @override
  void onReady() {
    super.onReady();
    _setInitialScreen(auth.currentUser);
  }
  _setInitialScreen(User? user) async {
    if(user == null){  
    await Future.delayed(const Duration(seconds: 2));
      Get.offAll(() => SplashScreen());
      Get.offAll(() => AuthenticScreen());
    }else if (auth.currentUser!.uid != 'JfbPPdFfKlbqdFj4vF4Vy3FdGs93'){
      Get.offAll(() =>BottomBarUser());
    }else{
      Get.offAll(() => BottomBarScreen());
    }
  }

  void logIn() async {
    try{
      await auth
      .signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim())
      .then((result) {
        if(result.user!.uid == 'JfbPPdFfKlbqdFj4vF4Vy3FdGs93'){
          Get.offAll(() => BottomBarScreen());
        }else{
          Get.offAll(() =>BottomBarUser());
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

     Stream<List<MyUser>> getUsers()=>
        firebaseFirestore.collection(usersCollection)
        .snapshots().map((event) => event.docs.map((e) => MyUser.fromMap(e.data())).toList());
  

  List<MyUser> checkUsers(){
    userlist.bindStream(getUsers());
    return userlist;
  }

}
