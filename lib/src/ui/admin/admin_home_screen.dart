import 'package:appreposteria/src/other/bottom_navigatorbar.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/ui/admin/upload_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';

class AdminHomePage extends StatefulWidget {
  static const String route = "/HomePage";
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late double height, width;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          title: Text("Admin",  
                style: TextStyle(
                fontWeight: FontWeight.w800, 
                color: Colors.black,
                fontSize: 20)),
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () {
              authController.signOut();
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),

        ),
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
        body: _buildBody(constraints),
      );
      }
    );
  }


 _buildBody(constraints){
      var height = constraints.maxHeight;
      var width = constraints.maxWidth;
      return SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: 0.05 * height,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0,),
                  )
                ),
                 _buildRichText(),
                Container(
                  height: 0.56 * height,
                  width: width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(    
                          children: [
                                
                          ],
                        ),                        
                      ),
                     ],
                  ),
                ),
              ]
            )
          ]
        )
       );   
 }

    _buildRichText() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0,right: 5.0, top: 1.0),
      child: RichText(
        text: 
              TextSpan(
                  text:  "Bienvenido, Administrador",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, 
                      color: Colors.black,
                      fontSize: 20)),    
      ),
    );
  }
}