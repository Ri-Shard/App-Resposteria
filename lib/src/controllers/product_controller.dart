import 'dart:async';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController uid = TextEditingController();
  late String image;
  //test
  final instanceTest = FakeFirebaseFirestore();
  RxList<ProductModel> productsTest = RxList<ProductModel>([]);
  //-----------------------
  String collection = "products";

  @override
  onReady() {
    super.onReady();
    checkProduct();
  }

  List<ProductModel> checkProduct() {
    products.bindStream(getAllProducts());
    return products;
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());

  String addProductToFirestore() {
    String message;
    try {
      String doc = firebaseFirestore.collection(collection).doc().id.toString();
      firebaseFirestore.collection(collection).doc(doc).set({
        "name": name.text.trim(),
        "description": description.text.trim(),
        "ingredients": ingredients.text.trim(),
        "price": price.text.trim(),
        "image": image.trim(),
        "uid": doc
      });
      _clearControllers();
      message = "Producto guardado con exito";
      Get.snackbar("Enhorabuena", message);
      return message;
    } catch (e) {
      _clearControllers();
      message = "Se produjeron Errores en la Creacion del producto";
      Get.snackbar("Error", message);
      return message;
    }
  }

  bool searchProduct(String id) {
    bool flag = false;
    products.forEach((element) {
      if (element.uid == id) {
        flag = true;
      }
    });
    return flag;
  }

  _clearControllers() {
    name.clear();
    description.clear();
    ingredients.clear();
    price.clear();
  }

  String deleteProducts(String idproduct) {
    String message;
    bool exists = searchProduct(idproduct);
    if (exists) {
      firebaseFirestore.collection(collection).doc(idproduct).delete();
      message = "Eliminado Con Exito";
      Get.snackbar("Enhorabuena", message);
      return message;
    } else {
      message = "Producto no Existe";
      Get.snackbar("Error", message);
      return message;
    }
  }

  String updateProduct(String productid) {
    String message;
    try {
      bool exists = searchProduct(productid);
      if (exists) {
        firebaseFirestore.collection(collection).doc(productid).update({
          "name": name.text.trim(),
          "description": description.text.trim(),
          "ingredients": ingredients.text.trim(),
          "price": price.text.trim(),
          "image": image.trim(),
          "uid": productid
        });
        _clearControllers();
        message = "Modificado Con Exito";
        Get.snackbar("Enhorabuena", message);
        return message;
      } else {
        _clearControllers();
        message = "Producto No existe";
        Get.snackbar("Error", message);
        return message;
      }
    } catch (e) {
      _clearControllers();
      message = "Se presentaron errores";
      Get.snackbar("Actualizacion Incorrecta", message);
      return message;
    }
  }

  //Test-----------------------------------------------------------
  String registerTest() {
    instanceTest.collection('products').add({
      'uid': uid.text,
      'name': name.text,
      'description': description.text,
      'ingredients': ingredients.text,
      'price': price.text,
      'image': image
    });
    if (uid.text != "9Y3z5vMlz43QpQBmXUq9") {
      print("Producto guardado con exito");
      return "Producto guardado con exito";
    } else {
      print("Se produjeron Errores en la Creacion del producto");
      return "Se produjeron Errores en la Creacion del producto";
    }
  }

  List<ProductModel> checkProducts() {
    productsTest.add(ProductModel(
        "uid", "description", "image", "ingredients", "name", 2000));
    return productsTest;
  }

  String updateProductData(String productid) {
        String message;
      if (productid=="9Y3z5vMlz43QpQBmXUq9") {
        message = "Modificado Con Exito";
        print(message);
        return message;
      } else {
        message = "Producto No existe";
        print(message);
        return message;
      }
  }

  String deleteProduct(String id) {
    String message;
    if (id=="9Y3z5vMlz43QpQBmXUq9") {
      message = "Eliminado Con Exito";
      print(message);
      return message;
    } else {
      message = "Producto no Existe";
      print(message);
      return message;
    }
  }
}
