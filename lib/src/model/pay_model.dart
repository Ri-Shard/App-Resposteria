
import 'package:cloud_firestore/cloud_firestore.dart';

class PayModel{
  static const UID = "uid";
  static const ORDER = "order";
  static const DATE = "date";
  static const USER = "user";
  static const VALUE = "value";

   String? uid;
   String? order;
   String? date; 
   String? user;
   int? value;


  PayModel({this.uid,this.date,this.order,this.user,this.value});

  PayModel.fromMap(Map<String, dynamic> data){
    uid = data[UID];
    order = data[ORDER];
    date = data[DATE];
    user = data[USER];
    value = int.parse(data[VALUE]);
  }
    PayModel fromSnapshot(DocumentSnapshot snapshot){
    PayModel pay = PayModel();
    pay.value = snapshot[VALUE];
    pay.user = snapshot[USER];
    pay.date = snapshot[DATE];
    pay.order = snapshot[ORDER];
    pay.uid = snapshot[UID];
    
    return pay;
  }

}