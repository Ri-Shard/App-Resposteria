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
            Column(            
              children: authController.myuser.cart!
                  .map((cartItem) => CartItemWidget(cartItem: cartItem,))
                  .toList(),
            ),
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
