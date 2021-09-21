import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:appreposteria/src/other/bottom_bar_Admin.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/single_orders_widget.dart';
import 'package:appreposteria/src/ui/admin/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoToDeliveryPage extends StatefulWidget {
  GoToDeliveryPage({Key? key}) : super(key: key);

  @override
  _GoToDeliveryPageState createState() => _GoToDeliveryPageState();
}

class _GoToDeliveryPageState extends State<GoToDeliveryPage> {
    OrderModel ordermodel = OrderModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, leading: IconButton(
            onPressed: () {
              Get.offAll(()=>BottomBarScreen());
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
      body: _cardOrder(orderController.ordermodel)
    );
  }

  Widget _cardOrder(OrderModel order){
    if(order.status.toString() == "PEDIDO LISTO"){

      return Column(
        children:[
            Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/On_way.png')
          )
        ),
      ),
             Text("El pedido ya fue puesto a Disposicion del Domiciliario",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
        ]
      );
    }
               return Column(
                 children: [
                   Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppColors.kCategorypinkColor ),                 

                        child: new Column(
                          children: <Widget>[
                          Text(order.date.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),   
                          Text(order.status.toString(), style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),                           
                          SizedBox(height: 20,),                
                          Column(    
                          children:            
                          order.cart!
                            .map((cartItem) => SingleOrderWidget(cartItem: cartItem,))
                              .toList(),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("Total: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),   
                          Text(order.total.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),   
                          ],
                        ),
                        SizedBox(height: 20,),
                          ],
                        ),                               
                   ),
                    SizedBox(height: 20,),

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

                    Get.offAll(()=>OrdersScreen());
                    orderController.updateOrder(order);
                    Get.snackbar("Enhorabuena", "El pedido se encuentra esperando un Domiciliario");
                  },
                  color: AppColors.kCategorypinkColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Enviar a Domiciliario",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
                 ],
               );
                                                
    
}
}