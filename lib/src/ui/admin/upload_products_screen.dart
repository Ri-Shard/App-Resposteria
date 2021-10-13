import 'dart:io';

import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/bottom_bar_Admin.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/general_appbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class UploadProducts extends StatefulWidget {
  @override
  _UploadProductsState createState() => _UploadProductsState();
}

class _UploadProductsState extends State<UploadProducts> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  late PickedFile pickedImage;
  bool pick = false;

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'El Nombre es Requerido'),
    MaxLengthValidator(20, errorText: 'Nombre muy largo, pruebe uno mas corto'),
    MinLengthValidator(2, errorText: 'Nombre del producto muy corto')
  ]);
  final dscValidator = MultiValidator([
    RequiredValidator(errorText: 'La Descripcion es Requerida'),
    MaxLengthValidator(120,
        errorText: '120 Caracteres para describir el producto'),
    MinLengthValidator(10, errorText: 'Una descripcion del producto mas larga')
  ]);
  final ingValidator = MultiValidator([
    RequiredValidator(errorText: 'Los Ingredientes son Requeridos'),
    MaxLengthValidator(120,
        errorText:
            '120 Caracteres para escribir los ingredientes del producto'),
    MinLengthValidator(10, errorText: ' Que pocos ingredientes...')
  ]);
  final priceValidator = MultiValidator([
    RequiredValidator(errorText: 'Los Ingredientes son Requeridos'),
    MaxLengthValidator(5, errorText: 'Mucho precio'),
    MinLengthValidator(3, errorText: 'Poco Precio')
  ]);

  late double height, width;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: generalAppbar("Agregar Producto", BottomBarScreen()),
        body: body(),
      );
    });
  }

  Widget body() {
    return Form(
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
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  makeInputName(),
                  makeInputDesc(),
                  makeInputIngr(),
                  makeInputPrice(),
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
                    )),
                child: MaterialButton(
                  height: 50,
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      _pick('gallery');
                    } else {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.RIGHSLIDE,
                          headerAnimationLoop: true,
                          title: 'Error',
                          desc:
                              'No puedes seleccionar una imagen sin llenar los campos anteriores',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red)
                        ..show();
                    }
                  },
                  color: AppColors.kCategorypinkColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Agregar Imagen",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
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
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    if (pick == true) {
                      _upload();
                    } else {
                      Get.snackbar('ERROR', "Seleccione una Imagen");
                    }
                  },
                  color: AppColors.kCategorypinkColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Agregar",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInputIngr() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Ingredientes',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: ingValidator,
          controller: producsController.ingredients,
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget makeInputName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nombre del Producto',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: nameValidator,
          controller: producsController.name,
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget makeInputDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Descripcion',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: dscValidator,
          controller: producsController.description,
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget makeInputPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Precio",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          validator: priceValidator,
          controller: producsController.price,
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  _pick(String inputSource) async {
    try {
      pickedImage = (await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;
      pick = true;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _upload() async {
    final String fileName = path.basename(pickedImage.path);
    File imageFile = File(pickedImage.path);

    if (_formKey.currentState?.validate() == true) {
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

        AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Guardado',
            desc: 'Producto guardado Con exito',
            btnOkOnPress: () {
              Get.offAll(() => BottomBarScreen());
            },
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            })
          ..show();
        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Error',
            desc: 'Error al Guardar el producto',
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
          ..show();
        debugPrint(error.toString());
      }
    } else {
      Get.snackbar('ERROR', "Rellene los campos necesarios");
    }
  }
}
