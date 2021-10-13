import 'package:appreposteria/src/controllers/address_controller.dart';
import 'package:appreposteria/src/model/address_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
      test('Guardar Direccion', () async{
    String response = "";
    AddressController addressController = new AddressController();
    addressController.address.text = "calle 20d# 3-12 llegando al parque, una cuadra antes";
    addressController.city.text = "valledupar";
    addressController.barrio.text = "villa castro";
    addressController.name.text = "Deison";
    String id = "721";
      response = addressController.registerTest(id);
       expect(response, "Guardado correctamente");
  });
  
  test('Consultar Direccion', () {
    AddressController addressController = new AddressController();
    List<AddressModel> direccionReturn;
    List<AddressModel> direcciones;
    direccionReturn = addressController.checkAddress();
    direcciones = direccionReturn;
    expect(direcciones, direccionReturn);
  });
  
      test('Eliminar Direccion', () async{
    AddressController addressController = new AddressController();
    String response = "";
      String id = "553";
      response =  addressController.deleteAddress(id);
       expect(response, "Eliminado Con Exito");
  }); 
   
}