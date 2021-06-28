import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/controllers/address_controller.dart';
import 'package:appreposteria/src/controllers/auth_controller.dart';
import 'package:appreposteria/src/controllers/cart_controller.dart';
import 'package:appreposteria/src/controllers/delivery_controller.dart';
import 'package:appreposteria/src/controllers/order_controller.dart';
import 'package:appreposteria/src/controllers/product_controller.dart';
import 'package:appreposteria/src/ui/common/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value){
  Get.put(AuthController());
  Get.put(ProducsController());
  Get.put(CartController());
  Get.put(OrderController());
  Get.put(AddressController());
  Get.put(DeliveryController());
  });
  runApp(MyApp());
} 
  
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          theme: new ThemeData(            
            primarySwatch:Colors.pink
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
    ); 
  }
}
