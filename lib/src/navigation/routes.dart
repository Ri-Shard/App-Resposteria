import 'package:appreposteria/src/ui/admin/admin_home_screen.dart';
import 'package:appreposteria/src/ui/auth/auth_screen.dart';
import 'package:appreposteria/src/ui/auth/login_screen.dart';
import 'package:appreposteria/src/ui/auth/register_screen.dart';
import 'package:appreposteria/src/ui/common/splash_screen.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {

  Routes._();
  static final routes = [

  //auth
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: '/auth', page: () => AuthenticScreen()),
  GetPage(name: '/register', page: () => RegisterPage()),
  GetPage(name: '/login', page: () => Login()),
  //User view
  GetPage(name: '/storeHome', page: () => AuthenticScreen()),
  GetPage(name: '/cart', page: () => RegisterPage()),
  GetPage(name: '/productPage', page: () => Login()),
  //Admin View
  GetPage(name: '/loadProducts', page: () => AuthenticScreen()),
  GetPage(name: '/adminHome', page: () => AdminHomePage()),
  GetPage(name: '/orders', page: () => Login()),
  ];


}