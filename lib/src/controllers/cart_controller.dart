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

  String addProductToCart(ProductModel product) {
    String message;
    try {
      bool itssaved = _isItemAlreadyAdded(product);
      if (itssaved) {
        message = "Revisa tu carrito ${product.name} ya se encuentra añadido";
        Get.snackbar("Error", message);
        return message;
      } else {
        String itemId = Uuid().toString();
        authController.updateCart({
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
        message = "${product.name} fue agregado a tu carrito";
        Get.snackbar("Enhorabuena", message);
        return message;
      }
    } catch (e) {
      message = "Error, No se pudo agregar este producto";
      Get.snackbar("Error", message);
      return message;
    }
  }

  void addcartItemModelToCart(CartItemModel product) {
    try {
      String itemId = Uuid().toString();
      authController.updateCart({
        "cart": FieldValue.arrayUnion([
          {
            "id": itemId,
            "name": product.name,
            "quantity": 1,
            "price": product.price,
            "image": product.image,
            "productId": product.productId,
            "cost": product.price
          }
        ])
      });
    } catch (e) {
      Get.snackbar("Error", "No se pudo agregar este producto");
      debugPrint(e.toString());
    }
  }

  removeCartItem(CartItemModel cartItem) {
    try {
      authController.updateCart({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
      authController.listenToUser();
    } catch (e) {
      Get.snackbar("Error", "No se pudo remover este producto");
    }
  }

  String remove(String productid) {
    String message;
    try {  
    authController.listenToUser();
    List<CartItemModel>? tmpcart = authController.myuser.cart;
    var toRemove = [];
    if (tmpcart!.length == 1) {
      clearCart();
    } else {
      tmpcart.forEach((cartitem) {
        if (productid == cartitem.productId) {
          toRemove.add(cartitem);
        }
      });
    }
    tmpcart.removeWhere((element) => toRemove.contains(element));
    clearCart();
    tmpcart.forEach((element) {
      addcartItemModelToCart(element);
    });
        message = "Eliminado con exito";
        Get.snackbar("Enhorabuena", message);
        return message;
    } catch (e) {
     message = "No se pudo remover este producto";
     Get.snackbar("Error", message);
     return message;
    }
  }

  clearCart() {
    authController.updateCart({"cart": []});
  }
//guardar el carro menos el item que voy guardar, despues hacer un merge

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

  bool _isItemAlreadyAdded(ProductModel product) => authController.myuser.cart!
      .where((item) => item.productId == product.uid)
      .isNotEmpty;

  void decreaseQuantity(CartItemModel item) {
    if (item.quantity == 1) {
      remove(item.name.toString());
    } else {
      remove(item.name.toString());
      item.quantity = (item.quantity - 1);
      authController.updateCart({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(CartItemModel item) {
    if (item.quantity >= 1) {
    } else {}
    remove(item.name.toString());
    item.quantity = (item.quantity + 1);
    logger.i({"quantity": item.quantity});
    authController.updateCart({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }

  
       String registerTest(ProductModel product){
      bool flag = false;
       if(flag == true){
        print("${product.name} fue agregado a tu carrito");
        return "${product.name} fue agregado a tu carrito";
       }else{
        print("Revisa tu carrito ${product.name} ya se encuentra añadido");
       return "Revisa tu carrito ${product.name} ya se encuentra añadido";
       }
    }
}
