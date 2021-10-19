import 'package:appreposteria/src/controllers/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async{
  
      test('Prueba Login', () async{
    AuthController authController = new AuthController();
    String response = "";
      authController.email.text = "pepe@gmail.com";
      authController.password.text = "1111111";
      response = authController.loginTest();
       expect(response,"Logeado Correctamente");
  });
}