import 'package:appreposteria/src/controllers/cart_controller.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
      test('Guardar Producto en Carrito', () async{
    String response = "";
    CartController cartController = new CartController();
     ProductModel product = new ProductModel("9Y3z5vMlz43QpQBmXUq9",
      "Delicioso postre de oreo",
       "https://firebasestorage.googleapis.com/v0/b/restaurantapp-d447a.appspot.com/o/scaled_image_picker10191081529401536.jpg?alt=media&token=e827ff0d-1430-49a8-af22-c0e22dcaef73",
        "Leches Oreo y Cosas varias",
         "cheesecake de oreo",
          2000); 
      response = cartController.registerTest(product);
       expect(response, "${product.name} fue agregado a tu carrito");
  });
}

