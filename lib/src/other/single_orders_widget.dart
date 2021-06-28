import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/other/custom_text.dart';
import 'package:flutter/material.dart';

class SingleOrderWidget extends StatelessWidget {
  final CartItemModel cartItem;

  const SingleOrderWidget({Key? key, required this.cartItem}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Padding(
            padding:
            const EdgeInsets.all(8.0),
            child: Image.network(
              cartItem.image!,
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
                        text: cartItem.name,
                      )),
                ],
              )),
          Padding(
            padding:
            const EdgeInsets.all(14),
            child: CustomText(
              text: "\$${cartItem.cost}",                          
              size: 22,
              weight: FontWeight.bold,
            ),
          ),
        ],
      ); 
  }
}




  

