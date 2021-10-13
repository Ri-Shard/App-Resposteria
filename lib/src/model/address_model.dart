import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  static const ADDRESS = "address";
  static const CITY = "city";
  static const BARRIO = "barrio";
  static const NAME = "name";
  static const ID = "id";  

  String? city;
  String? barrio;
  String? name;
  String? address;
  String? id;


AddressModel({this.address,this.name,this.city,this.barrio,this.id});


  AddressModel fromSnapshot(DocumentSnapshot snapshot){
    AddressModel order = AddressModel();
    order.name = snapshot[NAME];
    order.city = snapshot[CITY];
    order.barrio = snapshot[BARRIO];
    order.address = snapshot[ADDRESS];
    order.id = snapshot[ID];
    
    return order;
  }

  AddressModel.fromMap(Map<String, dynamic> data){
    barrio = data[BARRIO];
    city = data[CITY];
    name= data[NAME];
    address = data[ADDRESS];
    id = data[ID];
  }
  
  Map toJson() => {
      "address" : address,
      "city" : city,
      "barrio" : barrio ,   
      "name" : name  ,  
      "id" : id    
  };

}