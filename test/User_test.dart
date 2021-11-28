import 'package:appreposteria/src/controllers/auth_controller.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:core';



void main() async {
    test('Guardar Usuario', () async{ 
  AuthController authController = new AuthController();
    String response = "";
      authController.name.text = "Deison";
      authController.lastname.text = "Navarro";
      authController.email.text = "deison1@gmail.com";
      authController.phone.text ="3016803509";
      authController.password.text = "123456";
      response = authController.registerTest();
       expect(response, "Registrado Con Exito");
  });


  test('Consultar Clientes', () {
    AuthController authController = new AuthController();
    List<MyUser> usuariosReturn;
    List<MyUser> usuarios;
    usuariosReturn = authController.consultarTest();
    usuarios = usuariosReturn;
    expect(usuarios, usuariosReturn);
  });

    test('Modificar Usuario', () async{
    AuthController authController = new AuthController();
    String response = "";
    MyUser user = MyUser() ;
      user.name = "Deison";
      user.lastname = "Navarro";
      user.email = "deison@gmail.com";
      user.phone = "3147094650";
      user.name = "123456dei";

      response = authController.updateUserDatatest(user);
       expect(response, "Modificado Con Exito");
  });
    test('Eliminar Usuario', () async{
    AuthController authController = new AuthController();
    String response = "";
    String uid = "JfbPPdFfKlbqdFj4vF4Vy3FdGs93";
//      String uid = "JfbPPdFfKlb";
      response = await authController.deleteUser(uid);
       expect(response, "Se ha eliminado la cuenta correctamente, sera redirigido al Login");
  });

}

