import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/other/custom_text.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  final CartItemModel cartItem;

  const CartItemWidget({Key? key, required this.cartItem}): super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          cartController.removeCartItem((widget.cartItem));
        });
      }, 
    
    background: Container(color: Colors.red),
        child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Padding(
            padding:
            const EdgeInsets.all(8.0),
            child: Image.network(
              widget.cartItem.image!,
              width: 80,
            ),
          ),
          Expanded(
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 14),
                      child: CustomText(
                        text: widget.cartItem.name,
                      )),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                              Icons.chevron_left),
                          onPressed: () {
                          setState(() {
                           cartController.decreaseQuantity(widget.cartItem);
                          });
                          }),
                      Padding(
                        padding:
                        const EdgeInsets.all(
                            8.0),
                        child: CustomText(
                          text: widget.cartItem.quantity.toString(),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons
                              .chevron_right),
                          onPressed: () {
                          setState(() {
                           cartController.increaseQuantity(widget.cartItem);
                          });
                          }),
                    ],
                  )
                ],
              )),
          Padding(
            padding:
            const EdgeInsets.all(14),
            child: CustomText(
              text: "\$${widget.cartItem.cost}",                          
              size: 22,
              weight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
