  
import 'dart:async';
import 'dart:io';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController price = TextEditingController();
  File? image;
  String? filename;
  File? imageFile;
  String collection = "products";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());

   addProductToFirestore(String productUid){
    firebaseFirestore.collection(collection).doc(productUid).set({
      "name": name.text.trim(),
      "uid": productUid,
      "description": description.text.trim(),
      "ingredients": ingredients.text.trim(),
      "price": price.text.trim(),
    });
  }

_upload() async{
        // Uploading the selected image with some custom meta data
        await firebaseStorage.ref(filename).putFile(
            imageFile!,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'admin',
              'description': 'Some description...'
            }));
      }


}    // Uploading the selected image with some custom meta data
