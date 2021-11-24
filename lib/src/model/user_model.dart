import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item_model.dart';

class MyUser{
    static const UID = "uid";
    static const EMAIL = "email";
    static const CART = "cart";
    static const NAME = "name";
    static const LASTNAME = "lastname";
    static const PHONE = "phone";

    String? uid;
    String? email;
    String? name;
    String? lastname;
    String? phone;
   List<CartItemModel>? cart; 

  MyUser({ this.uid, this.email, this.name,this.cart,this.lastname,this.phone});

  MyUser.fromMap(Map<String, dynamic> data){
    uid = data[UID];
    email = data[EMAIL];
    name= data[NAME];
    lastname= data[LASTNAME];
    phone= data[PHONE];
  }

  MyUser fromSnapshot(DocumentSnapshot snapshot){
    MyUser user = MyUser();
    user.name = snapshot[NAME];
    user.lastname = snapshot[LASTNAME];
    user.email = snapshot[EMAIL];
    user.uid = snapshot[UID];
    user.phone = snapshot[PHONE];
    return user;
  }
}