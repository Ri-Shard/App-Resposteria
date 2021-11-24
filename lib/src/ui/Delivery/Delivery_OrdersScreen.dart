import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/other/bottom_bar_Delivery.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/single_orders_widget.dart';
import 'package:appreposteria/src/ui/admin/order_GoToDelivery_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DeliveryOrdersScreen extends StatefulWidget {
  @override
  _DeliveryOrdersScreenState createState() => _DeliveryOrdersScreenState();
}

class _DeliveryOrdersScreenState extends State<DeliveryOrdersScreen> {
  late double height, width;
  OrderModel ordermodel = OrderModel();
  String status = "ENTREGADO";
  @override
  void initState() {
    super.initState();
    authController.listenToUser();
    authController.deliverylist = authController.getDelivery(); 
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => BottomBarDelivery());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
          title: Row(
            children: [
              Column(children: [
                Text(
                  "Pedidos",
                  style: TextStyle(color: Colors.black),
                ),
              ]),
            ],
          ),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        status = "ENTREGADO";
                      });
                    },
                    icon: Icon(Mdi.accountArrowRight),
                    color: Colors.black),
                IconButton(
                    onPressed: () {
                      setState(() {
                        status = "RECIBIDO POR USUARIO";
                      });
                    },
                    icon: Icon(Mdi.accountCheck),
                    color: Colors.black),
              ],
            ),
          ],
        ),
        body: StreamBuilder(
            stream: firebaseFirestore.collection("orders").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: length(snapshot),
                  itemBuilder: (BuildContext context, int index) {
                    return  _if(index, snapshot, status);
                    
                  });
            }),
      );
    });
  }

  Widget _if(int index, AsyncSnapshot<QuerySnapshot> snapshot, String status) {
    if (snapshot.data!.docs.length != 0) {
      if (snapshot.data!.docs[index].get("status") == status && _searchDelivery(snapshot,index)  ) {
        return GestureDetector(
          onTap: () {
            orderController.checkCart(snapshot.data!.docs[index].get("dat"));
            showMaterialModalBottomSheet(
              context: context,
              builder: (context) => Container(
                height: 350,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.topCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Carrito",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            "Total: " +
                                "\$${snapshot.data!.docs[index].get("total")}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: orderController.cartlistOrder
                          .map((cartItem) => SingleOrderWidget(
                                cartItem: cartItem,
                              ))
                          .toList(),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Regresar",
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                ),
              ),
            );
            orderController.cartlistOrder.clear();
          },          
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.kCategorypinkColor),
                child: new Column(
                  children: <Widget>[
                    Text(snapshot.data!.docs[index].get("date"),
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      snapshot.data!.docs[index].get("status"),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data!.docs[index].get("address"),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data!.docs[index].get("deliveryname"),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2,
                      width: 300,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Total: \$" + snapshot.data!.docs[index].get("total"),
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }
      return Container();
    } else {
      return _noOrders();
    }
  }

  bool _searchDelivery(AsyncSnapshot<QuerySnapshot> snapshot, int index) {

 bool retur = false;
 String delivery = snapshot.data!.docs[index].get("delivery");
    authController.deliverylist.forEach((element) {
      String id = element.toString();
      if(id == delivery){                
      retur = true;
      }
    });
    return retur;
  }
  Widget _noOrders() {
    return Column(children: [
      Image(image: AssetImage("images/Empty_Orders.png")),
      SizedBox(height: 20),
      Text("No hay Pedidos",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
      SizedBox(height: 20),
    ]);
  }

  int length(AsyncSnapshot<QuerySnapshot> snapshot) {
    int suma = 0;
    if (snapshot.data!.docs.length == 0) {
      suma = 1;
    } else {
      suma = snapshot.data!.docs.length;
    }

    return suma;
  }
}
