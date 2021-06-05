import 'package:appreposteria/src/constants/app_constants.dart';
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  double? totalCartPrice = 0.0;

  @override
  void onReady() {
    super.onReady();
    ever(authController.myuser, changeCartTotalPrice);
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.name} is already added");
      } else {
        String itemId = Uuid().toString();
        authController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "productId": product.uid,
              "name": product.name,
              "description": product.description,
              "ingredients": product.ingredients,
              "quantity": 1,
              "price": product.price,
              "image": product.image,
              "cost": product.price
            }
          ])
        });
        Get.snackbar("Item added", "${product.name} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo agregar este producto");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      authController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "No se pudo remover este producto");
    }
  }

  changeCartTotalPrice(MyUser userModel) {
    totalCartPrice = 0.0;
    if (userModel.cart!.isNotEmpty) {
      userModel.cart!.forEach((cartItem) {
        totalCartPrice = (totalCartPrice! + (cartItem.cost!));
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      authController.myuser.value.cart!
          .where((item) => item.productId == product.uid)
          .isNotEmpty;



  void decreaseQuantity(CartItemModel item){
    if(item.quantity == 1){
      removeCartItem(item);
    }else{
      removeCartItem(item);
      item.quantity = (item.quantity! - 1);
          authController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

    void increaseQuantity(CartItemModel item){
      removeCartItem(item);
      item.quantity = (item.quantity! + 1);
      logger.i({"quantity": item.quantity});
          authController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
  }
}