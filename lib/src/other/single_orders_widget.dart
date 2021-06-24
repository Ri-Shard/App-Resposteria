import 'package:appreposteria/src/model/order_model.dart';
import 'package:flutter/material.dart';

class SingleOrderWidget extends StatelessWidget {
  final OrderModel orderModel;

  const SingleOrderWidget({required this.orderModel});
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Text(orderModel.uid.toString(),style:TextStyle(color:Colors.black)),
    );
  }

}