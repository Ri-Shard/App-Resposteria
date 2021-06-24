import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ADDRESS = "address";
  static const UID = "uid";  
  static const DATE = "date";  
  static const NAME = "name";  
  static const CART  = "cart";  

  String? address;
  String? uid;
  String? name;
  String? date;
  List<CartItemModel>? cart; 

OrderModel({this.address,this.name,this.date,this.uid,this.cart});


  OrderModel fromSnapshot(DocumentSnapshot snapshot){
    OrderModel order = OrderModel();
    order.name = snapshot[NAME];
    order.address = snapshot[ADDRESS];
    order.date = snapshot[DATE];
    order.uid = snapshot[UID];
    order.cart = _convertCartItems(snapshot[CART] ?? []);
    
    return order;
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

  OrderModel.fromMap(Map<String, dynamic> data){
    uid = data[UID];
    name = data[NAME];
    address = data[ADDRESS];
    date = data[DATE];
    cart = cartItemsToJson().cast<CartItemModel>();
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();


}