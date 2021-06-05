import 'package:appreposteria/src/model/item_model.dart';
import 'package:appreposteria/src/other/bottom_navigatorbar.dart';
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/single_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height, width;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          title: Text("Productos",  
                style: TextStyle(
                fontWeight: FontWeight.w800, 
                color: Colors.black,
                fontSize: 20)),
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () {
              authController.signOut();
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),

        ),
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
        body: _buildBody(constraints),
      );
      }
    );
  }


 _buildBody(constraints){
      var height = constraints.maxHeight;
      var width = constraints.maxWidth;
      return SafeArea(
        child: Stack(
          children: [
            Obx(()=>GridView.count(
                crossAxisCount: 2,
                childAspectRatio: .63,
                padding: const EdgeInsets.all(10),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 10,
                children: producsController.products.map((ProductModel product) {
                  debugPrint(product.toString());
                  return SingleProductWidget(product: product,);
                }).toList())) 
          ]
        )
       );   
 }

    _buildRichText() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0,right: 5.0, top: 1.0),
      child: RichText(
        text: 
              TextSpan(
                  text:  "Bienvenido, ${authController.myuser.value.name}",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, 
                      color: Colors.black,
                      fontSize: 20)),    
      ),
    );
  }
}