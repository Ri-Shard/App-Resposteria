import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/bottom_navigatorbar.dart';
import 'package:appreposteria/src/other/cart_item_widget.dart';
import 'package:appreposteria/src/other/custom_buttom.dart';
import 'package:appreposteria/src/other/custom_text.dart';
import 'package:appreposteria/src/other/general_appbar.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mdi/mdi.dart';
import 'package:get/get.dart';

class ShoppingCartWidget extends StatefulWidget {
  @override
  _ShoppingCartWidgetState createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
    late double height, width;

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: generalAppbar("Carrito",HomePage()),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             bottomNavigatorBar(_currentIndex, 0, Mdi.home,false),
              bottomNavigatorBar(_currentIndex,1, Mdi.cart,false),
              bottomNavigatorBar(_currentIndex, 2, Mdi.shoppingOutline,false),
              bottomNavigatorBar(_currentIndex, 3, Mdi.accountSettings,false),
            ],
          ),
        ),
        body: _buildBody(constraints,context),
      );
      }
    );
  }

   _buildBody(constraints,context){
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
            Obx(()=>Column(            
              children: authController.myuser.value.cart!
                  .map((cartItem) => CartItemWidget(cartItem: cartItem,))
                  .toList(),
            )),
                    ],
        ),
        Positioned(
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
            ))
      ],
    );
   }
}
