import 'package:appreposteria/src/constants/app_constants.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:appreposteria/src/ui/admin/admin_home_screen.dart';
import 'package:appreposteria/src/ui/auth/auth_screen.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AuthController extends GetxController {
  static  AuthController instance = Get.find();

  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  RxBool isAdmin = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  Rx<MyUser> myuser = MyUser().obs;
  
  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }
  _setInitialScreen(User? user){
    if(user == null){
      Get.offAll(() => AuthenticScreen());
    }else if (isAdmin == false.obs){
      myuser.bindStream(listenToUser());
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
          isAdmin = true.obs;
          Get.offAll(() => AdminHomePage());
        }
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
        .doc(firebaseUser.value!.uid)
        .update(data);
  }
    Stream<MyUser> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => MyUser.fromSnapshot(snapshot));
}
