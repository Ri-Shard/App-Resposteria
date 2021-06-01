import 'dart:io';

import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/bottom_navigatorbar.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/general_appbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdi/mdi.dart';
import 'package:path/path.dart' as path;

import 'admin_home_screen.dart';

class UploadProducts extends StatefulWidget {

  @override
  _UploadProductsState createState() => _UploadProductsState();
}

class _UploadProductsState extends State<UploadProducts> {
      final _formKey = GlobalKey<FormState>();
         final picker = ImagePicker();
         late PickedFile pickedImage;
          String? emailValidator(String? value) {
    return (value == null || value.isEmpty) ? 'Campo Requerido' : null;
  }
  @override
    late double height, width;
    int _currentIndex = 1;
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: generalAppbar("Admin",AdminHomePage()),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             bottomNavigatorBar(_currentIndex, 0, Mdi.home),
              bottomNavigatorBar(_currentIndex,1, Mdi.cart),
              bottomNavigatorBar(_currentIndex, 2, Mdi.shoppingOutline),
              bottomNavigatorBar(_currentIndex, 3, Mdi.accountSettings),
            ],
          ),
        ),
        body: body(),
      );
      }
    );
  }

          Widget body(){
            return  Form(
              key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 120,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Agregar Producto", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Text("Digita la informacion Basica de tu producto", style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700]
                    ),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    makeInput(label: "Nombre Producto",controller:producsController.name,validator: emailValidator),
                    makeInput(label: "Descripcion",controller: producsController.description,validator: emailValidator),
                    makeInput(label: "Ingredientes",controller: producsController.ingredients,validator: emailValidator),
                    makeInput(label: "Precio", controller: producsController.price, validator: emailValidator),
                  ],
                ),
                  Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )
                  ),
                  child: MaterialButton(
                    height: 50,
                     onPressed: () async{ _pick('gallery');}, 
                    color: AppColors.kCategorypinkColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: Text("Agregar Imagen", style: TextStyle(
                      fontWeight: FontWeight.w600, 
                      fontSize: 18
                    ),),
                  ),
                ),
                Text("Imagen:"),
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                     onPressed: () async{ _upload();}, 
                    color: AppColors.kCategorypinkColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("Agregar", style: TextStyle(
                      fontWeight: FontWeight.w600, 
                      fontSize: 18
                    ),),
                  ),
                ),
              ],
          ),
        ),
      ),
            );
}

  Widget makeInput({label, obscureText = false, controller, validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
          ),
        ),
        SizedBox(height: 5,),
      ],
    );
  }
  FirebaseStorage storage = FirebaseStorage.instance;
  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  _pick(String inputSource)async{

        try {
                pickedImage = (await picker.getImage(
                  source: inputSource == 'camera'
                      ? ImageSource.camera
                      : ImageSource.gallery,
                  maxWidth: 1920))!;
        } catch (e) {
                print(e);
        }
  }
  Future<void> _upload() async {
              final String fileName = path.basename(pickedImage.path);
              File imageFile = File(pickedImage.path);
     try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'Admin',
              'description': 'Some description...'
            }));
          String url = await storage.ref(fileName).getDownloadURL();  
          producsController.image = url;
          producsController.addProductToFirestore();
        // Refresh the UI
        setState((){});
      } on FirebaseException catch (error) {
        print(error);
      }
  
  }
}


