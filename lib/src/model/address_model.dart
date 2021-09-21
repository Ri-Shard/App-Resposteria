import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  static const ADDRESS = "address";
  static const CITY = "city";
  static const BARRIO = "barrio";
  static const NAME = "name";
  static const DATE = "date";  

  String? city;
  String? barrio;
  String? name;
  String? address;
  String? date;


AddressModel({this.address,this.name,this.city,this.barrio,this.date});


  AddressModel fromSnapshot(DocumentSnapshot snapshot){
    AddressModel order = AddressModel();
    order.name = snapshot[NAME];
    order.city = snapshot[CITY];
    order.barrio = snapshot[BARRIO];
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
  }
  
  Map toJson() => {
      "address" : address,
      "city" : city,
      "barrio" : barrio ,   
      "name" : name  ,  
      "date" : date    
  };

}