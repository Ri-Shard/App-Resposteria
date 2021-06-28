import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/other/bottom_navigatorbar.dart';
import 'package:appreposteria/src/other/cart_item_widget.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
              Get.offAll(HomePage());
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ), 
        title:Row(
        children: [
          Column(
            children: [
              Text(
                "Mis Pedidos",
                style: TextStyle(color: Colors.black),
              ),
            ]
          ),      
        ],
      ),
         ),
      body: 
                orderController.orderlist.length== 0 ?
                        Container(                             
                    child: imageMessage()                
               )
      :
      StreamBuilder(
      stream: firebaseFirestore
      .collection("users")
      .doc(authController.myuser.uid)
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
                Text(snapshot.data!.docs[index].get("date"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),   
                Text(snapshot.data!.docs[index].get("total"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),   
                SizedBox(height: 20,),                
                Column(    
                children:            
                ordelmodel.fromSnapshot(snapshot.data!.docs[index]).cart!
                  .map((cartItem) => CartItemWidget(cartItem: cartItem,))
                    .toList(),
              ),
              SizedBox(height: 20,),
                Text(snapshot.data!.docs[index].get("status"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),                               
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
              bottomNavigatorBar(_currentIndex, 0, Mdi.home,false,context),
              bottomNavigatorBar(_currentIndex,1, Mdi.cart,false,context),
              bottomNavigatorBar(_currentIndex, 2, Mdi.shoppingOutline,false,context),
              bottomNavigatorBar(_currentIndex, 3, Mdi.accountSettings,false,context),
            ],
          ),
        ),
    );
  });
}
    imageMessage(){
    return Column(
                    children: [                
                      Image(image: AssetImage("images/Empty_Orders.png")),
                      SizedBox(
                        height: 20
                      ),
                      Text("No hay Pedidos",
                          style: TextStyle(fontWeight : FontWeight.bold,fontSize: 25 )),
                       SizedBox(
                        height: 20
                         ),
                          ]
                  );
  }
}