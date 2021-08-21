import 'package:appreposteria/src/controllers/address_controller.dart';
import 'package:appreposteria/src/controllers/auth_controller.dart';
import 'package:appreposteria/src/controllers/cart_controller.dart';
import 'package:appreposteria/src/controllers/delivery_controller.dart';
import 'package:appreposteria/src/controllers/order_controller.dart';
import 'package:appreposteria/src/controllers/product_controller.dart';
import 'package:get/get.dart';

AuthController authController = Get.find();
ProducsController producsController = ProducsController.instance;
CartController  cartController = CartController.instance;
OrderController orderController = OrderController.instance;
AddressController addressController = AddressController.instance;
DeliveryController deliveryController = DeliveryController.instance;
