import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/address_model.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/other/cart_item_widget.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  Widget build(BuildContext context) {
    List<CartItemModel> cartlist = authController.myuser.cart!;
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, leading: IconButton(
            onPressed: () {
              Get.offAll(HomePage());
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ), ),
      body: Column(
        children: [
          Text("Mis Pedidos", ),
                      Column(    
                children:            
                    authController.myuser.cart!
                    .map((cartItem) => CartItemWidget(cartItem: cartItem,))
                    .toList(),
              ),
          Text(authController.addressModel.address.toString())
        ],
      ),
    );
  }
}