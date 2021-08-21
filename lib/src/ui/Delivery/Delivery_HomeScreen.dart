import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DeliveryHomeScreen extends StatefulWidget {
  DeliveryHomeScreen({Key? key}) : super(key: key);

  @override
  _DeliveryHomeScreenState createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Reposteria App",  
                style: TextStyle(
                fontWeight: FontWeight.w800, 
                color: Colors.black,
                fontSize: 20)),
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                animType: AnimType.RIGHSLIDE,
                headerAnimationLoop: true,
                title: '¿Seguro que deseas salir?',
                btnOkOnPress: () {
                  authController.signOut();
                },                
                btnOkColor: AppColors.kCategorypinkColor,
                btnCancelColor: AppColors.kCategorypinkColor,
                btnCancelOnPress: (){},
              )
              ..show();
              
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),

        ),  
        
      );
  }
}