import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/address_model.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
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
        ), ),
      body: 
      StreamBuilder(
      stream: firebaseFirestore
      .collection("pedidos")
      .doc(authController.myuser.uid)
      .collection(authController.myuser.uid.toString())
      .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Column(
                children: <Widget>[
                   Text(snapshot.data!.docs[index].get("date")),
                   
                Column(    
                children:            
                ordelmodel.fromSnapshot(snapshot.data!.docs[index]).cart!
                  .map((cartItem) => CartItemWidget(cartItem: cartItem,))
                    .toList(),
              ),
              
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
}