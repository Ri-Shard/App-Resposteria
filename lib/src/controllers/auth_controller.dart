import 'package:appreposteria/src/constants/app_constants.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:appreposteria/src/other/bottom_bar_Admin.dart';
import 'package:appreposteria/src/other/bottom_bar_Delivery.dart';
import 'package:appreposteria/src/other/bottom_bar_User.dart';
import 'package:appreposteria/src/ui/auth/auth_screen.dart';
import 'package:appreposteria/src/ui/common/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxBool isAdmin = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  MyUser myuser = MyUser();
  List<String> deliverylist = [];
  RxList<MyUser> userlist = RxList<MyUser>([]);

  @override
  void onInit() async {
    super.onInit();
    if (auth.currentUser != null) {
      listenToUser();
      checkUsers();
      deliverylist = await getDelivery();
    }
  }

  @override
  void onReady() {
    super.onReady();
    _setInitialScreen(auth.currentUser);
  }

  _setInitialScreen(User? user) async {
    deliverylist = await getDelivery();
    if (user == null) {
      await Future.delayed(const Duration(seconds: 2));
      Get.offAll(() => SplashScreen());
      Get.offAll(() => AuthenticScreen());
    } else if (user.uid == 'JfbPPdFfKlbqdFj4vF4Vy3FdGs93') {
      Get.offAll(() => BottomBarScreen());
    } else if (deliverylist
        .any((element) => (element == auth.currentUser!.uid))) {
      Get.offAll(() => BottomBarDelivery());
    } else {
      Get.offAll(() => BottomBarUser());
    }
  }

  void logIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        getDelivery();
        if (result.user!.uid == 'JfbPPdFfKlbqdFj4vF4Vy3FdGs93') {
          Get.offAll(() => BottomBarScreen());
          Get.snackbar("Bienvenido ADMINISTRADOR", "");
        } else if (deliverylist
            .any((element) => (element == result.user!.uid))) {
          deliverylist = [];
          Get.offAll(() => BottomBarDelivery());
          Get.snackbar("Bienvenido", "");
        } else {
          Get.offAll(() => BottomBarUser());
          Get.snackbar("Bienvenido", "");
        }
        listenToUser();
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.hashCode.toString());
      if (e.hashCode.toInt() == 505284406) {
        Get.snackbar("Login Incorrecto", "Email no registrado");
      }
      if (e.hashCode.toInt() == 185768934) {
        Get.snackbar("Login Incorrecto", "Contraseña Incorrecta");
      }
    }
  }

  void register() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userUid = result.user!.uid;
        Get.snackbar("Enhorabuena", "Registrado Con Exito");
        _addUserToFirestore(_userUid);
      });
    } catch (e) {
      debugPrint(e.hashCode.toString());
      if (e.hashCode.toInt() == 34618382) {
        Get.snackbar("Registro Incorrecto", "Email registrado Con otra Cuenta");
      }
    }
  }

  void signOut() async {
    auth.signOut();
    Get.offAll(() => AuthenticScreen());
  }

  _addUserToFirestore(String userUid) {
    firebaseFirestore.collection(usersCollection).doc(userUid).set({
      "name": name.text.trim(),
      "lastname": lastname.text.trim(),
      "uid": userUid,
      "email": email.text.trim(),
      "cart": []
    });
  }

  _clearControllers() {
    name.clear();
    lastname.clear();
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

  Stream<List<MyUser>> getUsers() => firebaseFirestore
      .collection(usersCollection)
      .snapshots()
      .map((event) => event.docs.map((e) => MyUser.fromMap(e.data())).toList());

  Future<List<String>> getDelivery() async {
    List<String> aux = [];
    try {
      await firebaseFirestore.collection("delivery").get().then(((event) {
        event.docs.forEach((element) {
          aux.add(element.id);
        });
      }));
    } catch (e) {}
    print(aux.toString());
    return aux;
  }

  List<MyUser> checkUsers() {
    userlist.bindStream(getUsers());
    return userlist;
  }
}
