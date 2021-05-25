import 'package:appreposteria/src/ui/auth/auth_screen.dart';
import 'package:appreposteria/src/ui/auth/login_screen.dart';
import 'package:appreposteria/src/ui/auth/register_screen.dart';
import 'package:appreposteria/src/ui/common/splash_screen.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  //auth
  static const splash = '/';
  static const auth = '/auth';
  static const register = '/register';
  static const logIn = '/logIn';
  //User view
  static const storeHome = '/storeHome';
  static const cart = '/cart';
  static const productPage = '/productPage';
  //Admin View
  static const loadProducts = '/loadProducts';
  static const adminHome = '/adminHome';
  static const orders = '/orders';


  static Route routes(RouteSettings routeSettings) {
    print('Route name: ${routeSettings.name}');

    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case auth:
        return _buildRoute(AuthenticScreen.create);
      case register:
        return _buildRoute(SignupPage.create);
      case logIn:
        return _buildRoute(Login.create);
      case storeHome:
        return _buildRoute(AdventurePage.create);

      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) => MaterialPageRoute(builder: (context) => build(context));
}