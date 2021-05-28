/*
class MyUser {
  final String uid;
  final String email;
  final String name;

  MyUser(
      {required this.uid,
      required this.email,
      required this.name,});

  factory MyUser.fromMap(Map data) {
    return MyUser(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name,};
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item_model.dart';

class MyUser{
    static const UID = "uid";
    static const EMAIL = "email";
    static const NAME = "name";
    static const CART = "cart";

    String? uid;
    String? email;
    String? name;
   List<CartItemModel>? cart;

  MyUser({ this.uid, this.email, this.name,this.cart});

  MyUser.fromSnapshot(DocumentSnapshot snapshot){
    name = snapshot.data()![NAME];
    email = snapshot.data()![EMAIL];
    uid = snapshot.data()![UID];
    cart = _convertCartItems(snapshot.data()![CART] ?? []);
  }

  
  List<CartItemModel> _convertCartItems(List cartFomDb){
    List<CartItemModel> _result = [];
    if(cartFomDb.length > 0){
      cartFomDb.forEach((element) {
      _result.add(CartItemModel.fromMap(element));
    });
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();

}