
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryModel   {
  static const ID = "id";
  static const PLACA = "placa";
  static const NAME = "name";
  static const VEHICULO = "vehiculo";
  static const ESTADO = "estado";
  static const CEDULA = "cedula";
  static const EMAIL = "email";

   String? id;
   String? placa;
   String? name; 
   String? vehiculo;
   String? estado;
   String? cedula;
   String? email;

  DeliveryModel({this.estado,this.id,this.name,this.placa,this.vehiculo,this.cedula,this.email});

  DeliveryModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    placa = data[PLACA];
    name = data[NAME];
    vehiculo = data[VEHICULO];
    estado = data[ESTADO];
    email = data[EMAIL];
    cedula = data[CEDULA];
  }

    DeliveryModel fromSnapshot(DocumentSnapshot snapshot){
    DeliveryModel user = DeliveryModel();
    user.name = snapshot[NAME];
    user.email = snapshot[EMAIL];
    user.placa = snapshot[PLACA];
    user.id = snapshot[ID];
    user.vehiculo = snapshot[VEHICULO];
    user.estado = snapshot[ESTADO];
    user.cedula = snapshot[CEDULA];
    return user;
  }
}