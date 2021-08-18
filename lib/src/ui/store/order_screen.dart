import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/other/bottom_bar_User.dart';
import 'package:appreposteria/src/other/single_orders_widget.dart';
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
        bool mostrar = false;
        int? long;

    @override
void initState() { 
  super.initState();
  authController.listenToUser();
  orderController.listenToOrder();
  long = orderController.checkAddress().length;
  
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
              Get.offAll(BottomBarUser());
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
            return Dismissible(
                            key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          if(snapshot.data!.docs[index].get("status") != "ENTREGADO"){
          orderController.deleteOrder(ordelmodel.fromSnapshot(snapshot.data!.docs[index]));
          }else{
            Get.snackbar("No puede eliminar", "Este pedido ya fue enviado");
          }
        });
      },  
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Icon(Mdi.trashCan),
                ],
              ),
            ),
                 child: new Card(
                child: new Column(
                  children: <Widget>[
                  Text(snapshot.data!.docs[index].get("date"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),   
                  Text("Total: \$"+snapshot.data!.docs[index].get("total"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),   
                  SizedBox(height: 20,),                
                  Column(    
                  children:            
                  ordelmodel.fromSnapshot(snapshot.data!.docs[index]).cart!
                    .map((cartItem) => SingleOrderWidget(cartItem: cartItem,))
                      .toList(),
                ),
                SizedBox(height: 20,),
                    Text(snapshot.data!.docs[index].get("status"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)                                                 
                  ],
                ),
              ),
            );
          }
        );
      }
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