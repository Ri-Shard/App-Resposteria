import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/other/bottom_navigatorbar.dart';
import 'package:appreposteria/src/ui/admin/admin_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late double height, width;
  OrderModel ordelmodel = OrderModel();
    int _currentIndex = 2;

    @override
void initState() { 
  super.initState();
  authController.listenToUser();
}
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints)
    {  
       height = constraints.maxHeight;
      width = constraints.maxWidth;
        return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, leading: IconButton(
            onPressed: () {
              Get.offAll(AdminHomePage());
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ), 
        title:Row(
        children: [
          Column(
            children: [
              Text(
                "Pedidos",
                style: TextStyle(color: Colors.black),
              ),
            ]
          ),      
        ],
      ),
         ),
      body: 
      StreamBuilder(
      stream: firebaseFirestore
      .collection("pedidos")
      .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Column(
                children: <Widget>[             
                SizedBox(height: 20,),                
              SizedBox(height: 20,),
                ],
              ),
            );
          }
        );
      }
    ),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottomNavigatorBar(_currentIndex, 0, Mdi.home,true,context),
              bottomNavigatorBar(_currentIndex,1, Mdi.cart,true,context),
              bottomNavigatorBar(_currentIndex, 2, Mdi.shoppingOutline,true,context),
              bottomNavigatorBar(_currentIndex, 3, Mdi.accountSettings,true,context),
            ],
          ),
        ),
    );
  });
}
}