import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/other/bottom_bar_User.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/single_orders_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late double height, width;
  OrderModel ordelmodel = OrderModel();
  bool mostrar = false;
  int? long;
  double _rating = 0.0;
  @override
  void initState() {
    super.initState();
    authController.listenToUser();
    orderController.listenToOrder();
    long = orderController.checkAddress().length;
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
              Get.offAll(BottomBarUser());
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
                  "Mis Pedidos",
                  style: TextStyle(color: Colors.black),
                ),
              ]),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: firebaseFirestore.collection("orders").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int _index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        setState(() {
                          if (snapshot.data!.docs[_index].get("status") !=
                              "ENTREGADO") {
                            orderController.deleteOrder(ordelmodel
                                .fromSnapshot(snapshot.data!.docs[_index]));
                          } else {
                            Get.snackbar("No puede eliminar",
                                "Este pedido ya fue enviado");
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
                      child: _if(_index, snapshot),
                    );
                  });
            }),
      );
    });
  }

  Widget _if(int index, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.data!.docs.length != 0) {
      if (snapshot.data!.docs[index].get("uid") == authController.myuser.uid) {
        return Column(
          
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
                    snapshot.data!.docs[index].get("deliveryname"),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: ordelmodel
                        .fromSnapshot(snapshot.data!.docs[index])
                        .cart!
                        .map((cartItem) => SingleOrderWidget(
                              cartItem: cartItem,
                            ))
                        .toList(),
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
            snapshot.data!.docs[index].get("status")== "ENTREGADO"?            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )),
                    child: Column(
                      children: [
                        Text("Satisfaccion con el Pedido"),
                        RatingBar.builder(
                          initialRating: 3,
                          itemCount: 5,
                          itemBuilder: (context, __index) {
                            switch (__index) {
                              case 0:
                                return Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                );
                              case 1:
                                return Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                                );
                              case 2:
                                return Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                );
                              case 3:
                                return Icon(
                                  Icons.sentiment_satisfied,
                                  color: Colors.lightGreen,
                                );
                              case 4:
                                return Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                );
                              default:
                                return SnackBar(content: Text(""));
                            }
                          },                          
                          onRatingUpdate: (rating) {
                                _rating = rating;
                       },
                        ),
                        TextButton.icon(onPressed: () {
                          orderController.updateUserOrder(ordelmodel
                                .fromSnapshot(snapshot.data!.docs[index]));}, icon: Icon(Icons.arrow_right_alt), label: Text("Evaluar Pedido")), 
                      ],
                    ))
              ],
            )
            :
            SizedBox(height:10)
          ],
        );
      }
      return Column(children: [
        Image(image: AssetImage("images/Empty_Orders.png")),
        SizedBox(height: 20),
        Text("No hay Pedidos",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        SizedBox(height: 20),
      ]);
    } else {
      return Column(children: [
        Image(image: AssetImage("images/Empty_Orders.png")),
        SizedBox(height: 20),
        Text("No hay Pedidos",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        SizedBox(height: 20),
      ]);
    }
  }
}
