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
  int totalCartPrice = 0;

  @override
  void onReady() {
    super.onReady();
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Revisa tu carrito", "${product.name} ya se encuentra añadido");
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
        Get.snackbar("Producto agregado", "${product.name} fue agregado a tu carrito");
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo agregar este producto");
      debugPrint(e.toString());
    }
  }

   removeCartItem(CartItemModel cartItem)  {
    try { 
      authController.updateUserData({
          "cart" : FieldValue.arrayRemove([cartItem.toJson()])
      });
            authController.listenToUser();
    } catch (e) {
      Get.snackbar("Error", "No se pudo remover este producto");
    }
  }
  remove(String productid) {
    List<CartItemModel>? tmpcart = authController.myuser.cart;
    var toRemove = [];

    tmpcart!.forEach((cartitem) {
      if(productid == cartitem.id){
        toRemove.add(cartitem);
      }
    });
        tmpcart.removeWhere((element) => toRemove.contains(element));
         authController.updateUserData({
        "cart": FieldValue.arrayUnion(tmpcart)
      });
  }
  clearCart() {
        authController.updateUserData({
        "cart": []
      });
  }

  int changeCartTotalPrice(MyUser userModel) {
    totalCartPrice = 0;
    if (userModel.cart!.isNotEmpty) {
      userModel.cart!.forEach((cartItem) {
       totalCartPrice = (totalCartPrice + (cartItem.cost!));     
      });
    return totalCartPrice;
    }
    return totalCartPrice;
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      authController.myuser.cart!
          .where((item) => item.productId == product.uid)
          .isNotEmpty;

  void decreaseQuantity(CartItemModel item){
    if(item.quantity == 1){
      remove(item.name.toString());
    }else{
      remove(item.name.toString());
      item.quantity = (item.quantity - 1);
          authController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }
    void increaseQuantity(CartItemModel item){
      if(item.quantity >= 1){

      }else{}
      remove(item.name.toString());     
       item.quantity = (item.quantity + 1);
      logger.i({"quantity": item.quantity});
          authController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
  }
}





