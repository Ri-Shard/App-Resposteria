import 'package:appreposteria/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final user = MyUser();
  @override
  void onInit() {
    super.onInit();
  }
  @override
  get onStart => super.onStart;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  get onDelete => super.onDelete;

  @override
  void onReady() {
    super.onReady();
  }

 Future<String> logIn(String email, String password)async{ 
    String msg;
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance.collection('users').doc(email).get().then((value) {
      user.email = value.data()!['email'];
      user.name = value.data()!['name'];
    });
    msg = 'Success';
    }catch (e){
      msg = e.toString();
    }
    return msg;
  }
  Future<String> signUp(String email, String password, String name) async{
    String msg;
    try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(email).set({
          'name' : name, 
          'email':email
        });
      msg = 'Success';

    } catch (e) {
     msg = e.toString();
    }
    return msg;
  }

}