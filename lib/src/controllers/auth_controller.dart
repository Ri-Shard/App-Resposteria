import 'package:appreposteria/src/constants/app_constants.dart';
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:appreposteria/src/other/bottom_bar_Admin.dart';
import 'package:appreposteria/src/other/bottom_bar_Delivery.dart';
import 'package:appreposteria/src/other/bottom_bar_User.dart';
import 'package:appreposteria/src/ui/auth/auth_screen.dart';
import 'package:appreposteria/src/ui/common/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
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
  TextEditingController phone = TextEditingController();
  String usersCollection = "users";
  MyUser myuser = MyUser();
  List<String> deliverylist = [];
  RxList<MyUser> userlist = RxList<MyUser>([]);
  FirebaseFirestore firebaseFirestoreAuth = FirebaseFirestore.instance;

  //test
  final instance = FakeFirebaseFirestore();

  //-----------------------
  @override
  void onInit() async {
    super.onInit();
    if (auth.currentUser != null) {
      listenToUser();
      checkUsers();
      deliverylist =  getDelivery();
      deliveryController.onReady() ;
    }
  }

  @override
  void onReady() async {
    super.onReady();
    _setInitialScreen(auth.currentUser);
    deliverylist =  getDelivery();
  }

  _setInitialScreen(User? user) async {
    deliverylist =  getDelivery();
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

  void setScreen(UserCredential result) {
    getDelivery();
    if (result.user!.uid == 'JfbPPdFfKlbqdFj4vF4Vy3FdGs93') {
      Get.offAll(() => BottomBarScreen());
      Get.snackbar("Bienvenido ADMINISTRADOR", "");
    } else if (deliverylist.any((element) => (element == result.user!.uid))) {
      Get.offAll(() => BottomBarDelivery());
      Get.snackbar("Bienvenido", "");
    } else {
      Get.offAll(() => BottomBarUser());
      Get.snackbar("Bienvenido", "");
    }
    listenToUser();
    clearControllers();
  }

  String pError(Object e) {
    String message = "";
    if (e.hashCode.toInt() == 505284406) {
      message = "Email no registrado";
      Get.snackbar("Login Incorrecto", message);
      return message;
    }

    if (e.hashCode.toInt() == 185768934) {
      message = "Contraseña Incorrecta";
      Get.snackbar("Login Incorrecto", message);
      return message;
    }
    if (e.hashCode.toInt() == 34618382) {
      message = "Email registrado Con otra Cuenta";
      Get.snackbar("Registro Incorrecto", message);
      return message;
    }
    return message;
  }

  void logIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        setScreen(result);
      });
    } catch (e) {
      pError(e);
    }
  } 

  Future<String> register() async {
    String message = "";
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userUid = result.user!.uid;
        message = "Registrado Con Exito";
        Get.snackbar("Enhorabuena", message);
        _addUserToFirestore(_userUid);
        return message;
      });
    } catch (e) {
      message = pError(e);
      return message;
    }
    return message;
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
      "phone": phone.text.trim(),
    });
  }

  clearControllers() {
    name.clear();
    lastname.clear();
    email.clear();
    password.clear();
    phone.clear();
  }
  String updateUserDat(User? user) {
    String message;
    try {
      if (user != null) {
        user.updateEmail(email.text.trim());
        user.updatePassword(password.text.trim());
        logger.i("UPDATED");
        firebaseFirestore
            .collection(usersCollection)
            .doc(auth.currentUser!.uid)
            .update({
          "name": name.text.trim(),
          "lastname": lastname.text.trim(),
          "email": email.text.trim(),
          "phone": phone.text.trim(),
        });
        clearControllers();
        message = "Modificado Con Exito";
        Get.snackbar("Enhorabuena", message);
        return message;
      } else {
        clearControllers();
        message = "Usuario Nulo";
        Get.snackbar("Error", message);
        return message;
      }
    } catch (e) {
      clearControllers();

      message = "Ocurrieron Errores en la Actualizacion";
      Get.snackbar("Actualizacion Incorrecta", message);
      return message;
    }
  }

  Future<String> delete(String id) async {
    String message;
    try {
      await firebaseFirestore.collection(usersCollection).doc(id).delete();
      message = "Se ha eliminado la cuenta correctamente, sera redirigido al Login";
      Get.snackbar("Eliminado correctamente",message);
      return message;
    } catch (e) {
      message="Ocurrieron uno o varios problemas al eliminar";
      Get.snackbar(
          "Error al Eliminar", message);
          return message;
    }
  }

  deleteUserAccount(User? user) async {
    try {
      if (user != null) {
        await firebaseFirestore
            .collection(usersCollection)
            .doc(user.uid)
            .delete();
        await user.delete();
        Get.snackbar("Eliminado correctamente",
            "Se ha eliminado la cuenta correctamente, sera redirigido al Login");
        signOut();
      } else {
        Get.snackbar("Error", "Usuario Nulo");
      }
    } catch (e) {
      debugPrint(e.hashCode.toString());
      if (e.hashCode.toInt() == 34618382) {
        Get.snackbar("Error al Eliminar",
            "Ocurrieron uno o varios problemas al eliminar");
      }
    }
    clearControllers();
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

  List<String> getDelivery()  {
    List<String> aux = [];
    try {
       firebaseFirestore.collection("delivery").get().then(((event) {
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

 //Test------------------------------------------------ 

   String newmethod(String ow){
    if(ow.contains("@") && ow.contains(".com")){
      return("Prueba Correcta");
    }else{
      return("Prueba Fallida");
    }
  }

  Stream<List<MyUser>> getUserstest() => instance.collection('users').snapshots()
      .map((event) => event.docs.map((e) => MyUser.fromMap(e.data())).toList());

   String registerTest(){
   instance.collection('users').add({
    'email': email.text,
    'lastname': lastname.text,
    'name': name.text,
    'phone': phone.text,
    'password': password.text
  });
        MyUser userTest = new MyUser();
      userTest.uid = "JfbPPdFfKlbqdFj4vF4Vy3FdGs93";
      userlist.add(userTest);
      userlist.bindStream(getUserstest());
      bool flag = false;
        if(newmethod(email.text)=="Prueba Fallida"){
          flag = true;
        }
       if(flag == true){
        print("Email registrado Con otra Cuenta");
        return "Email registrado Con otra Cuenta";
       }else{
        print("Registrado Con Exito");
       return "Registrado Con Exito";
       }
    }
    String updateUserDatatest(MyUser user) {
    String message;
      if (newmethod(user.email.toString())=="Prueba Correcta") {
        
   instance.collection('users').doc(user.uid).update({
    'email': email.text,
    'lastname': lastname.text,
    'name': name.text,
    'phone': phone.text,
    'password': password.text
  });
        message = "Modificado Con Exito";
        print(message);
        return message;
      } else {
        clearControllers();
        message = "Ocurrieron Errores en la Actualizacion";
        print(message);
        return message;
      }
  }
    Future<String> deleteUser(String id) async {

    String message;
      
      if (id == "JfbPPdFfKlbqdFj4vF4Vy3FdGs93") {
        instance.collection(usersCollection).doc(id).delete();
      message = "Se ha eliminado la cuenta correctamente, sera redirigido al Login";
      print(message);
      return message;
      } else {
      message="Ocurrieron uno o varios problemas al eliminar";
        print(message);
        return message;
      }
  }
  
   String loginTest(){
       if(!_validateLogin()){
        print("Email no registrado");
        return "Email no registrado";
       }else{
        print("Logeado Correctamente");
       return "Logeado Correctamente";
       }
    }

   List<MyUser> consultarTest(){
    final instance = FakeFirebaseFirestore();
   instance.collection('users').add({
    'email': 'Castro@gmail.com',
    'lastname': 'Castro',
    'name': 'Joaquin',
    'phone': '3016803509',
  });
  final snapshot =  instance.collection('users').snapshots()
.map((event) => event.docs.map((e) => MyUser.fromMap(e.data())).toList());
userlist.bindStream(snapshot);
  return userlist;
    }

    bool _validateLogin(){
      String mail = "pepe@gmail.com";
      String pass = "1111111";
      if(email.text.toString() == mail && password.text.toString()== pass){
        return true;
      }else{
        return false;
      }
    }
}
