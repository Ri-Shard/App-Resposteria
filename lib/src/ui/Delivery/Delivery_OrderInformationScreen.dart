import 'package:flutter/material.dart';

class DeliveryOrderInformation extends StatefulWidget {
  DeliveryOrderInformation({Key? key}) : super(key: key);

  @override
  _DeliveryOrderInformationState createState() => _DeliveryOrderInformationState();
}

class _DeliveryOrderInformationState extends State<DeliveryOrderInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text("Delivery Order Information"),
       ),
    );
  }
}