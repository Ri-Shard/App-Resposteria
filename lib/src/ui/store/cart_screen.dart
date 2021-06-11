import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/other/cart_item_widget.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/custom_buttom.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShoppingCartWidget extends StatefulWidget {
  @override
  _ShoppingCartWidgetState createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
    late double height, width;

  @override
  Widget build(BuildContext context) {

     return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: Get.height*0.7,
              child: Column(    
                children:            
                    authController.myuser.cart!
                    .map((cartItem) => CartItemWidget(cartItem: cartItem,))
                    .toList(),
              ),
            ),
                    ],
        ),
        Positioned(
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              child: CustomButton(           
                     
                  text: "Pedir(\$${cartController.changeCartTotalPrice(authController.myuser)})", onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.RIGHSLIDE,
                        headerAnimationLoop: true,
                        title: 'Exito',
                        desc:
                          'Pedido en Proceso',
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.check,
                        btnOkColor: AppColors.kCategorypinkColor)
                      ..show();
                  }),)
            )
      ],
    );
  }

}
