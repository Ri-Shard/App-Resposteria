import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/cart_item_widget.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/custom_buttom.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';


class ShoppingCartWidget extends StatefulWidget {
  @override
  _ShoppingCartWidgetState createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
    late double height, width;

  @override
  Widget build(BuildContext context) {

     return Scaffold(
       appBar: buildAppBar(context),
       body: 
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 5,
            ),
            authController.myuser.cart!.length == 0 ?
            Container(                             
                child: Column(
                  children: [
                    Image(image: AssetImage("images/empty_cart.png")),
                    Text("Carrito Vacio",
                        style: TextStyle(fontWeight : FontWeight.bold,fontSize: 25 )),]
                ),
                
            )
            :
            Column(    
                children:            
                    authController.myuser.cart!
                    .map((cartItem) => CartItemWidget(cartItem: cartItem,))
                    .toList(),
              ),
                    ],
        ),
       bottomNavigationBar: _bottom(),
     );
  }

    AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Column(
        children: [
          Text(
            "Carrito",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${authController.myuser.cart!.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }



  Widget _bottom(){
       return Container(
         width: 1,
         height: 60,
              padding: EdgeInsets.only(top:0, left: 10,right: 10,bottom: 10),
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
                  })
            );
  }

}
