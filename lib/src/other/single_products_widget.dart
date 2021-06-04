import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:appreposteria/src/other/custom_text.dart';
import 'package:flutter/material.dart';

class SingleProductWidget extends StatelessWidget {
  final ProductModel product;

  const SingleProductWidget({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Column(
        children: [
          Expanded(
                      child: Padding(
              padding: const EdgeInsets.all(8.0),
                     child: ClipRRect(
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                        child: Image.network(              
                            product.image!,
                            width: 200,
                        ),                     
                      ),
            ),
          ),
          CustomText(
            text: product.name,
            size: 18,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(
                  text: "\$${product.price}",
                  size: 22,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cartController.addProductToCart(product);
                  })
            ],
          ),
        ],
      ),
    );
  }

}