import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:appreposteria/src/other/custom_buttom.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  ProductScreen({required this.product});
  @override
  Widget build(BuildContext context) {

    final coursePrice = Container(
      child: new Text(
        // "\$20",
        "\$" + product.price.toString(),
        style: TextStyle(color: Colors.black,fontSize: 25),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.name.toString(),
          style: TextStyle(color: Colors.black, fontSize: 45.0),
        ),
        SizedBox(height:10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(product.image.toString()),
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
            Get.offAll(HomePage());
            },
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      product.description.toString(),
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: CustomButton(
          text: "Añadir al Carrito",
          onTap: (){
            authController.listenToUser();
            cartController.addProductToCart(product);
          },
         ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[topContentText,SizedBox(height: 90,), bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );

  }
}

