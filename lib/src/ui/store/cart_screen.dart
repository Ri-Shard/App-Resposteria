import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/cart_item_widget.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/custom_buttom.dart';
import 'package:appreposteria/src/ui/store/address_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ShoppingCartWidget extends StatefulWidget {
  @override
  _ShoppingCartWidgetState createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
    late double height, width;
@override
void initState() { 
  super.initState();
  cartController.checkCart();
}
String cartPrice =   cartController.cartTotalPrice().toString();
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
            cartController.checkCart().length == 0 ?
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
        
                    cartController.cartlist
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
      leading: Icon(Mdi.cart, color: Colors.black, size: 30,),
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Column(
            children: [
              Text(
                "Carrito",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "${cartController.cartlist.length} items",
                style: Theme.of(context).textTheme.caption,
              ), 
            ]
          ),
            SizedBox(
              width: 40,
            ),
            Text("Total: "+"\$$cartPrice",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.end,),
            IconButton(onPressed: (){  setState(() {cartController.clearCart(); cartController.checkCart();});},
            icon: Icon(Mdi.trashCan, color: Colors.black,))       
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
                  text: "Proceder a Pedir", onTap: () {
                    if (cartController.cartlist.length == 0) {
                                                                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        title: 'UPS',
                        desc:
                          'No puedes pedir con un carrito Vacio',
                        btnOkOnPress: () {
                    
                        },
                        btnOkColor: AppColors.kCategorypinkColor)
                      ..show();
                    }else{
                                                                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.NO_HEADER,
                        title: 'Ahora, Elige tu direccion',
                        desc:
                          'Seras Redirigido',
                        btnOkOnPress: () {
                        
                            showBarModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                color: Colors.white,
                                child: AddressScreen() ,
                              ),
                            );
                        },
                        btnOkColor: AppColors.kCategorypinkColor)
                      ..show();
                    }
                  })
            );
  }

}
