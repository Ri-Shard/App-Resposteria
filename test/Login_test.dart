
import 'package:appreposteria/src/controllers/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
      test('Prueba Login', () async{
    String response = "";
    AuthController authController = new AuthController();
      authController.email.text = "pepe1@gmail.com";
      authController.password.text = "1111111";
      response = authController.loginTest();
       expect(response,"Logeado Correctamente");
  });
}