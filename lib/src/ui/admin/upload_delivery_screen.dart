import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/general_appbar.dart';
import 'package:appreposteria/src/ui/admin/Delivery_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadDeliveryScreen extends StatefulWidget {
  UploadDeliveryScreen({Key? key}) : super(key: key);

  @override
  _UploadDeliveryScreenState createState() => _UploadDeliveryScreenState();
}

class _UploadDeliveryScreenState extends State<UploadDeliveryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? emailValidator(String? value) {
    return (value == null || value.isEmpty) ? 'Campo Requerido' : null;
  }
  late double height, width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: generalAppbar("Agregar Domiciliario",DomiciliariosPage()),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        body: body(),
      );
      });      
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
                  Image.asset("images/No_data.png",width: 200,),
                    SizedBox(height: 10,)           
                  ],
                ),
                Column(
                  children: <Widget>[
                    makeInput(label: "Nombre Domiciliario",controller:deliveryController.name,validator: emailValidator),
                    makeInput(label: "Vehiculo",controller: deliveryController.vehiculo,validator: emailValidator),
                    makeInput(label: "Placa", controller: deliveryController.placa, validator: emailValidator, ),
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
                    minWidth: double.infinity,
                    height: 60,
                     onPressed: () async{
                      deliveryController.addDeliveryToFirestore();
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.LEFTSLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        showCloseIcon: true,
                        title: 'Guardado',
                        desc:
                            'Domiciliario guardado Con exito',
                        btnOkOnPress: () {
                          Get.to(()=>DomiciliariosPage());
                        },
                        btnOkIcon: Icons.check_circle,
                        onDissmissCallback: (type) {
                        })
                      ..show();
                      }, 
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
  Widget makeInput({label, obscureText = false, controller, validator,type}) {
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
          keyboardType: type,
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
}





