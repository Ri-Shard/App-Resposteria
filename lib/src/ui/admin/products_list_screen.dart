import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:appreposteria/src/other/bottom_bar_Admin.dart';
import 'package:appreposteria/src/other/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';



class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(elevation: 0, backgroundColor: Colors.white, leading: IconButton(
            onPressed: () {
              Get.offAll(BottomBarScreen());
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ), 
        title:Row(
        children: [
          Column(
            children: [
              Text(
                "Listado Productos",
                style: TextStyle(color: Colors.black),
              ),
            ]
          ),      
        ],
      ),
         ),
      body: 
              producsController.products.length == 0 ?
              Container(                             
              child: Column(
                children: [
                  Image(image: AssetImage("images/No_data.png")),
                  Text("Listado de Productos Vacio",
                      style: TextStyle(fontWeight : FontWeight.bold,fontSize: 25 )),]
              ),
          
             )  
        :
      Stack(
          children: [
            Obx(()=>GridView.count(
                crossAxisCount: 2,
                childAspectRatio: .63,
                padding: const EdgeInsets.all(10),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 10,
                children: producsController.products.map((ProductModel product) {
                  return itemWidget(product,);
                }).toList())) 
          ]
        
       ));   
  }

  Widget itemWidget(ProductModel product){
        return Dismissible(
              key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          producsController.deleteProduct(product.uid.toString());
        });
      },  
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Icon(Mdi.trashCan),
                ],
              ),
            ),
          child: Container(
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
                              width: 220,
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
                      authController.listenToUser();
                      cartController.addProductToCart(product);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}