import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/bottom_navigatorbar.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
// ignore: must_be_immutable
class ProfileUI2 extends StatelessWidget {
    int _currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Perfil de usuario" ,  
                style: TextStyle(
                fontWeight: FontWeight.w800, 
                color: Colors.black,
                fontSize: 18)),
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () { 
              Get.to(()=>HomePage());       
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),

        ),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottomNavigatorBar(_currentIndex, 0, Mdi.home,false,context),
              bottomNavigatorBar(_currentIndex,1, Mdi.cart,false,context),
              bottomNavigatorBar(_currentIndex, 2, Mdi.shoppingOutline,false,context),
              bottomNavigatorBar(_currentIndex, 3, Mdi.accountSettings,false,context),
            ],
          ),
        ),
      body: SafeArea(
        child: Column(
          
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/Checklist.png"
                  ),
                  fit: BoxFit.cover
                )
              ),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0,2.5),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      "images/male_avatar.png"
                  ),
                  radius: 60.0,
                ),
              ),
            ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              authController.myuser.name.toString()
              ,style: TextStyle(
                fontSize: 25.0,
                color:Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400
            ),
            ),
            Text(
              "Usuario"
              ,style: TextStyle(
                fontSize: 15.0,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),

            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Pedidos",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(
                            height: 7,
                          ),
                          Text(orderController.orderlist.length.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300
                            ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),

          ],
        ),
      )
    );
  }
}