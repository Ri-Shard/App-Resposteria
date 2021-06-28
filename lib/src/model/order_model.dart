import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ADDRESS = "address";
  static const UID = "uid";  
  static const DATE = "date";  
  static const DAT = "dat";  
  static const NAME = "name";  
  static const CART  = "cart";  
  static const STATUS  = "status";  
  static const TOTAL  = "total";  

  String? address;
  String? uid;
  String? name;
  String? date;
  String? dat;
  String? status;
  String? total;
  List<CartItemModel>? cart; 

OrderModel({this.address,this.name,this.date,this.uid,this.cart,this.status,this.total,this.dat});

 
  OrderModel fromSnapshot(DocumentSnapshot snapshot){
    OrderModel order = OrderModel();
    order.name = snapshot[NAME];
    order.address = snapshot[ADDRESS];
    order.date = snapshot[DATE];
    order.dat = snapshot[DAT];
    order.uid = snapshot[UID];
    order.status = snapshot[STATUS];
    order.total = snapshot[TOTAL];
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
    dat = data[DAT];
    status = data[STATUS];
    total = data[TOTAL];
    cart = cartItemsToJson().cast<CartItemModel>();
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();


}