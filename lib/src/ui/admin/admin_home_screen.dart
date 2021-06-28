import 'package:appreposteria/src/model/item_model.dart';
import 'package:appreposteria/src/other/bottom_navigatorbar.dart';
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/single_products_widget.dart';
import 'package:appreposteria/src/ui/admin/user_list_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late double height, width;
  int _currentIndex = 0;
@override
void initState() { 
  super.initState();
  authController.listenToUser();
}
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          actions: [
           IconButton(onPressed: (){
             Get.to(()=>UsersList());
           }, icon: Icon(Mdi.accountDetailsOutline),color: Colors.black)   
          ],
          title: Text("Reposteria App",  
                style: TextStyle(
                fontWeight: FontWeight.w800, 
                color: Colors.black,
                fontSize: 20)),
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                animType: AnimType.RIGHSLIDE,
                headerAnimationLoop: true,
                title: '¿Seguro que deseas salir?',
                btnOkOnPress: () {
                  authController.signOut();
                },                
                btnOkColor: AppColors.kCategorypinkColor,
                btnCancelColor: AppColors.kCategorypinkColor,
                btnCancelOnPress: (){},
              )
              ..show();
              
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),

        ),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottomNavigatorBar(_currentIndex, 0, Mdi.home,true,context),
              bottomNavigatorBar(_currentIndex,1, Mdi.plus,true,context),
              bottomNavigatorBar(_currentIndex, 2, Mdi.shoppingOutline,true,context),
              bottomNavigatorBar(_currentIndex, 3, Mdi.cake,true,context),
            ],
          ),
        ),
        body: _buildBody(constraints),
      );
      }
    );
  }


 _buildBody(constraints){
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

}