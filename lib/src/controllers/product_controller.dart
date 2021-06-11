  
import 'dart:async';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController price = TextEditingController(); 
  late String image;
  String collection = "products";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());

   addProductToFirestore(){
    firebaseFirestore.collection(collection).doc().set({
      "name": name.text.trim(),
      "description": description.text.trim(),
      "ingredients": ingredients.text.trim(),
      "price": price.text.trim(),
      "image": image.trim(),
      "uid": firebaseFirestore.collection(collection).doc().id.toString()
          });
          _clearControllers();
  }

      _clearControllers() {
        name.clear();
        description.clear();
        ingredients.clear();
        price.clear();
       } 

}    // Uploading the selected image with some custom meta data
