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

  MyUser fromSnapshot(DocumentSnapshot snapshot){
    MyUser user = MyUser();
    user.name = snapshot.data()![NAME];
    user.email = snapshot.data()![EMAIL];
    user.uid = snapshot.data()![UID];
    user.cart = _convertCartItems(snapshot.data()![CART] ?? []);
    return user;
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