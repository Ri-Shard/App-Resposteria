import 'package:appreposteria/src/controllers/product_controller.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:core';

void main() {
  
      test('Guardar Producto', () async{
    ProducsController producsController = new ProducsController();
    String response = "";
    producsController.uid.text = "9Y3z5vMlz43QpQBmXUq8";
    producsController.name.text = "Malteada de Fresa";
    producsController.description.text = "Deliciosa Malteada de Fresa";
    producsController.ingredients.text= "Fresas, leche, azúcar, leche condensada";
    producsController.price.text ="15000";
    producsController.image = "https://firebasestorage.googleapis.com/v0/b/restaurantapp-d447a.appspot.com/o/scaled_image_picker10191081529401536.jpg?alt=media&token=e827ff0d-1430-49a8-af22-c0e22dcaef73";
      response = producsController.registerTest();
       expect(response, "Producto guardado con exito");
  });
  


  test('Consultar Productos', () {
    ProducsController producsController = new ProducsController();
    List<ProductModel> producsReturn;
    List<ProductModel> products;
    producsReturn = producsController.checkProducts();
    products = producsReturn;
    expect(products, producsReturn);
  });
      test('Modificar Productos', () async{
    ProducsController producsController = new ProducsController();
    String response = "";
    producsController.uid.text = "9Y3z5vMlz43QpQBmXUq9";
    producsController.name.text = "Cheesecake de oreo";
    producsController.description.text = "Delicioso cheesecake de oreo";
    producsController.ingredients.text= "Leche, oreo, crema";
    producsController.price.text ="5000";
    producsController.image = "https://firebasestorage.googleapis.com/v0/b/restaurantapp-d447a.appspot.com/o/scaled_image_picker10191081529401536.jpg?alt=media&token=e827ff0d-1430-49a8-af22-c0e22dcaef73";
      response = producsController.updateProductData(producsController.uid.text);
       expect(response, "Modificado Con Exito");
  });
  

      test('Eliminar Producto', () async{
    ProducsController producsController = new ProducsController();
    String response = "";
      String idproduct = "9Y43QpQBmXUq9";
      response =  producsController.deleteProduct(idproduct);
       expect(response, "Eliminado Con Exito");
  }); 
  
}