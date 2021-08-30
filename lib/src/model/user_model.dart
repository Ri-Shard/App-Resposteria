import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item_model.dart';

class MyUser{
    static const UID = "uid";
    static const EMAIL = "email";
    static const CART = "cart";
    static const NAME = "name";
    static const LASTNAME = "lastname";

    String? uid;
    String? email;
    String? name;
    String? lastname;
   List<CartItemModel>? cart; 

  MyUser({ this.uid, this.email, this.name,this.cart,this.lastname});

  MyUser.fromMap(Map<String, dynamic> data){
    uid = data[UID];
    email = data[EMAIL];
    name= data[NAME];
    lastname= data[LASTNAME];
  }

  MyUser fromSnapshot(DocumentSnapshot snapshot){
    MyUser user = MyUser();
    user.name = snapshot[NAME];
    user.lastname = snapshot[LASTNAME];
    user.email = snapshot[EMAIL];
    user.uid = snapshot[UID];
    user.cart = _convertCartItems(snapshot[CART] ?? []);
    return user;
  }
  List<CartItemModel> _convertCartItems(List cartFomDb){
    List<CartItemModel> _result = [];
    CartItemModel cartmodel = CartItemModel(quantity: 1);
    if(cartFomDb.length > 0){
      cartFomDb.forEach((element) {
      _result.add(cartmodel.fromMap(element));
    });
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();
}