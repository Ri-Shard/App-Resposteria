
class DeliveryModel   {
  static const ID = "id";
  static const PLACA = "placa";
  static const NAME = "name";
  static const VEHICULO = "vehiculo";
  static const ESTADO = "estado";

   String? id;
   String? placa;
   String? name; 
   String? vehiculo;
   String? estado;

  DeliveryModel(this.estado,this.id,this.name,this.placa,this.vehiculo);

  DeliveryModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    placa = data[PLACA];
    name = data[NAME];
    vehiculo = data[VEHICULO];
    estado = data[ESTADO];
  }
}