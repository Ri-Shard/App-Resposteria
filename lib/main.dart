import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/controllers/auth_controller.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/ui/common/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value){
  Get.put(AuthController());
  });
  runApp(MyApp());
} 
  
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
    ); 
  }
}
