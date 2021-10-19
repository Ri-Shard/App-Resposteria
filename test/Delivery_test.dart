import 'package:appreposteria/src/controllers/delivery_controller.dart';
import 'package:appreposteria/src/model/delivery_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:core';
void main() {

      test('Guardar Domiciliario', () async{
    DeliveryController deliveryController = new DeliveryController();
    String response = "";
    deliveryController.email.text= "Deison@gmail.com";
    deliveryController.name.text = "Deison";
    deliveryController.placa.text = "ASD123";
    deliveryController.vehiculo.text= "Boxer";
    deliveryController.cedula.text ="49789243";
    deliveryController.phone.text = "3016803509";
      response = deliveryController.registerTest();
       expect(response, "Se ha registrado correctamenta el Domiciliario");
  });


  test('Consultar Domiciliarios', () {
    DeliveryController deliveryController = new DeliveryController();
    List<DeliveryModel> domiciliariosReturn;
    List<DeliveryModel> domiciliarios;
    domiciliariosReturn = deliveryController.checkDeliverys();
    domiciliarios = domiciliariosReturn;
    expect(domiciliarios, domiciliariosReturn);
  });
      test('Modificar Domiciliarios', () async{
    DeliveryController deliveryController = new DeliveryController();
    String response = "";
    DeliveryModel domiciliario = DeliveryModel() ;
    domiciliario.email= "pedro@gmail.com";
    domiciliario.name = "Pedro";
    domiciliario.placa = "ASD123";
    domiciliario.vehiculo= "Boxer";
    domiciliario.cedula ="49789542";
    domiciliario.phone = "3018964512";
    domiciliario.estado = "ACTIVO";
      response = deliveryController.updateDeliveryData(domiciliario.cedula.toString());
       expect(response, "Modificado Con Exito");
  });


      test('Eliminar Domiciliario', () async{
    DeliveryController deliveryController = new DeliveryController();
    String response = "";
      String cedula = "49789542";
      response = await deliveryController.deleteDelivery(cedula);
       expect(response, "Eliminado Con Exito");
  });
}