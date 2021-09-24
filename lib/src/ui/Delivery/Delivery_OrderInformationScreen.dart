import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/other/bottom_bar_Delivery.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/single_orders_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryOrderInformation extends StatefulWidget {
  DeliveryOrderInformation({Key? key}) : super(key: key);

  @override
  _DeliveryOrderInformationState createState() =>
      _DeliveryOrderInformationState();
}

class _DeliveryOrderInformationState extends State<DeliveryOrderInformation> {
  OrderModel ordermodel = OrderModel();

  @override
  Widget build(BuildContext context) {
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
        ),
        body: _cardOrder(orderController.ordermodel));
  }

  Widget _cardOrder(OrderModel order) {
    // ignore: unnecessary_null_comparison
    if (order!= null) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.kCategorypinkColor),
            child: new Column(
              children: <Widget>[
                Text(order.date.toString(),
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  order.status.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: order.cart!
                      .map((cartItem) => SingleOrderWidget(
                            cartItem: cartItem,
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(order.total.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
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
                )),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.WARNING,
                  animType: AnimType.RIGHSLIDE,
                  headerAnimationLoop: true,
                  title: '¿Seguro que deseas marcar el pedido como entregado?',
                  btnOkOnPress: () {
                    orderController.updateDeliveryOrder(
                        order, deliveryController.delivery.id.toString(),deliveryController.delivery.name.toString());
                        ordermodel = new OrderModel();                      
                    Get.snackbar(
                        "Enhorabuena", "El pedido a sido entregado con exito");
                       Get.offAll(() => BottomBarDelivery());
                  },
                  btnOkColor: AppColors.kCategorypinkColor,
                  btnCancelColor: AppColors.kCategorypinkColor,
                  btnCancelOnPress: () {},
                )..show();

              },
              color: AppColors.kCategorypinkColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                "Pedido Entregado",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(children: [
        Image(image: AssetImage("images/Empty_Orders.png")),
        SizedBox(height: 20),
        Text("Debe seleccionar un pedido para detallar",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        SizedBox(height: 20),
      ]);
    }
  }
}
