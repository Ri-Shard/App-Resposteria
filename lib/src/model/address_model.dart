import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  static const ADDRESS = "address";
  static const CITY = "city";
  static const BARRIO = "barrio";
  static const NAME = "name";
  static const PHONE = "phone";  
  static const DATE = "date";  

  String? city;
  String? barrio;
  String? name;
  String? address;
  String? phone;
  String? date;


AddressModel({this.address,this.name,this.city,this.phone,this.barrio,this.date});


  AddressModel fromSnapshot(DocumentSnapshot snapshot){
    AddressModel order = AddressModel();
    order.name = snapshot[NAME];
    order.city = snapshot[CITY];
    order.barrio = snapshot[BARRIO];
    order.phone = snapshot[PHONE];
    order.address = snapshot[ADDRESS];
    order.date = snapshot[DATE];
    
    return order;
  }

  AddressModel.fromMap(Map<String, dynamic> data){
    barrio = data[BARRIO];
    city = data[CITY];
    name= data[NAME];
    address = data[ADDRESS];
    date = data[DATE];
    phone = data[PHONE];
  }
  
  Map toJson() => {
      "address" : address,
      "city" : city,
      "barrio" : barrio ,   
      "name" : name  ,  
      "phone" : phone   , 
      "date" : date    
  };

}