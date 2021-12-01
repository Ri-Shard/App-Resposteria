
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  FirebaseFirestore firebaseFirestorethis = FirebaseFirestore.instance;
  RxList<CartItemModel> cartlist = RxList<CartItemModel>([]);

  int totalCartPrice = 0;
  @override
  void onInit() async {
    super.onInit();
      checkCart();
    }
  @override
  void onReady() {
    checkCart();
        super.onReady();
  }

  Stream<List<CartItemModel>> getCart() => firebaseFirestore
      .collection("users")
      .doc(auth.currentUser!.uid)
      .collection("cart")
      .snapshots()
      .map((event) => event.docs.map((e) => CartItemModel.fromMap(e.data())).toList());

  List<CartItemModel> checkCart() {
    cartlist.bindStream(getCart());
    return cartlist;
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Revisa tu carrito", "${product.name} ya se encuentra añadido");
      } else {
        firebaseFirestorethis
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("cart")
        .doc(product.uid)
        .set(product.toMap(product));
        Get.snackbar("Producto agregado", "${product.name} fue agregado a tu carrito");
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo agregar este producto");
      debugPrint(e.toString());
    }
    checkCart();
  }

   removeCartItem(String id) async {
    try {
      await firebaseFirestorethis.collection("users").doc(auth.currentUser!.uid).collection("cart").doc(id).delete();
      Get.snackbar("Eliminado correctamente", "Se ha eliminado el producto");
    } catch (e) {
      Get.snackbar("Error", "No se pudo remover este producto");
    }
  }
  clearCart() {
    cartlist.forEach((element)  {
          firebaseFirestorethis.collection("users").doc(auth.currentUser!.uid).collection("cart").doc(element.productId).delete();
                Get.snackbar("Vaciado correctamente", "Se ha vaciado el carrito");
    });
  }

  int cartTotalPrice(){
    totalCartPrice = 0;
    cartlist.forEach((element){
      totalCartPrice = totalCartPrice + element.cost!.toInt();
    });
    
    return totalCartPrice;
  }

  bool _isItemAlreadyAdded(ProductModel product) {
    bool response = false;
    response = cartlist.any((element) => element.productId == product.uid);
    return response;
    }

  String decreaseQuantity(CartItemModel item){
    if(item.quantity == 1){
      removeCartItem(item.productId.toString());
      return "";
    }else{
      int quantity = item.quantity! - 1;
        firebaseFirestorethis
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("cart")
        .doc(item.productId)
        .update({
          "quantity": quantity,
          "cost": item.price!*quantity        
          });
        return quantity.toString();
    }
  }

    void increaseQuantity(CartItemModel item){
    if(item.quantity! > 10){
      Get.snackbar("Error", "Demasiados productos");
    }else{
      int aux = item.quantity! + 1;
        firebaseFirestorethis
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("cart")
        .doc(item.productId)
        .update({
          "quantity": aux,
          "cost": item.price!*aux
        });
    }
  }
}





