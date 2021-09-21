import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/delivery_model.dart';
import 'package:appreposteria/src/other/bottom_bar_Admin.dart';
import 'package:appreposteria/src/other/custom_text.dart';
import 'package:appreposteria/src/ui/admin/delivery_edit_screen.dart';
import 'package:appreposteria/src/ui/admin/upload_delivery_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';

class DomiciliariosPage extends StatefulWidget {
  DomiciliariosPage({Key? key}) : super(key: key);

  @override
  _DomiciliariosPageState createState() => _DomiciliariosPageState();
}

class _DomiciliariosPageState extends State<DomiciliariosPage> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(elevation: 0, backgroundColor: Colors.white, leading: IconButton(
            onPressed: () {
              Get.offAll(()=>BottomBarScreen());
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ), 
        title:Row(
        children: [
          Column(
            children: [
              Text(
                "Listado Domiciliarios",
                style: TextStyle(color: Colors.black),
              ),
            ]
          ),      
        ],
      ),
      actions: [
        IconButton(onPressed: (){
          Get.to(()=>UploadDeliveryScreen());
        }, icon: Icon(Mdi.plus,color: Colors.black,size: 40,))
      ],
         ),
      body: 
      
      deliveryController.deliverys.length == 0 ?
                        Container(                             
                    child: imageMessage()                
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
                children: deliveryController.deliverys.map((DeliveryModel deliveryModel) {
                  return itemWidget(deliveryModel,);
                }).toList())) 
          ]
        
       ));   
  }
    imageMessage(){
    return GestureDetector(
      onTap: 	(){
        Get.to(()=> UploadDeliveryScreen());
      },
          child: Column(
                    children: [                
                      Image(image: AssetImage("images/Empty_Orders.png")),
                      SizedBox(
                        height: 20
                      ),
                      Text("No hay Domiciliarios Añadidos",
                          style: TextStyle(fontWeight : FontWeight.bold,fontSize: 25 )),
                       SizedBox(
                        height: 20
                         ),
                      Text("Presione para añadir",
                          style: TextStyle(fontWeight : FontWeight.bold,fontSize: 18 )),
                        SizedBox(
                        height: 20
                         ),
                          ]
                  ),
    );
  }
    Widget itemWidget(DeliveryModel delivery){

        return GestureDetector(
          onTap: (){

            Get.to(() => EditDeliveryPage(  delivery: delivery,));
          },
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
                            child: Image.asset(    
                                "images/male_avatar.png",
                                width: 220,
                            ),                     
                          ),
                ),
              ),
              CustomText(
                text: delivery.name,
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
                      text: delivery.estado,
                      size: 22,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ],
          ),
      ),
        );
      

  }
}