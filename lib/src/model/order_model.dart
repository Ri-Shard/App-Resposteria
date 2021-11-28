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
  static const DELIVERY  = "delivery";  
  static const DELIVERYNAME  = "deliveryname";  
  static const CLIENTRATING  = "clientrating";  
  static const DATETIME = "datetime";  


  String? address;
  String? uid;
  String? name;
  String? date;
  String? datetime;
  String? dat;
  String? status;
  String? total;
  String? delivery;
  String? deliveryname;
  String? clientrating;
  List<CartItemModel>? cart; 

OrderModel({this.clientrating,this.datetime,this.deliveryname,this.delivery,this.address,this.name,this.date,this.uid,this.cart,this.status,this.total,this.dat});

 
  OrderModel fromSnapshot(DocumentSnapshot snapshot){
    OrderModel order = OrderModel();
    order.name = snapshot[NAME];
    order.address = snapshot[ADDRESS];
    order.date = snapshot[DATE];
    order.dat = snapshot[DAT];
    order.uid = snapshot[UID];
    order.status = snapshot[STATUS];
    order.total = snapshot[TOTAL];
    order.delivery = snapshot[DELIVERY];
    order.deliveryname = snapshot[DELIVERYNAME];
    order.clientrating = snapshot[CLIENTRATING];
    order.datetime = snapshot[DATETIME];
    
    return order;
  }
/*
  List<CartItemModel> _convertCartItems(List cartFomDb){
    List<CartItemModel> _result = [];
    CartItemModel cartmodel = CartItemModel(quantity: 1);
    if(cartFomDb.length > 0){
      cartFomDb.forEach((element) {
      _result.add(cartmodel.fromMa(element));
    });
    }
    return _result;
  }
 */

  OrderModel.fromMap(Map<String, dynamic> data){
    uid = data[UID];
    name = data[NAME];
    address = data[ADDRESS];
    date = data[DATE];
    dat = data[DAT];
    status = data[STATUS];
    total = data[TOTAL];
    delivery = data[DELIVERY];
    clientrating = data[CLIENTRATING];
    deliveryname = data[DELIVERYNAME];
    datetime = data[DATETIME];
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();


}