/*
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/item_model.dart';
import 'package:appreposteria/src/other/custom_paragraph.dart';
import 'package:appreposteria/src/other/general_appbar.dart';
import 'package:appreposteria/src/other/single_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Bienvenido, ${authController.myuser.name}" ,  
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
      body:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        padding: EdgeInsets.only(top:100,left:20,right:20),
        child: Column(
          children:[
            _searchTextFormField(),
            SizedBox(height:30 ),
            CustomParagraph(
              text:"Categorias",              
            ),
            SizedBox(height:30),
            _listViewCategory(),
            SizedBox(height:30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomParagraph(
                  text: "Mas Vendidos",
                  fontSize: 18,
                ),
                CustomParagraph(
                  text: "Ver Todos",
                  fontSize: 16,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
           // _buildBody(),
          ],
        ),
      )
    );
  }
    Widget _searchTextFormField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ),
    );
  }


  Widget _listViewCategory() {
        return Container(
        height: 100,
        child: ListView.separated(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade100,
                  ),
                  height: 60,
                  width: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("images/Photos.png"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomParagraph(
                  text: "Pasteles",
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 20,
          ),
        ),
      );    
  }
}

*/


















































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
          title: Text("Bienvenido, ${authController.myuser.name}" ,  
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
              bottomNavigatorBar(_currentIndex, 0, Mdi.home,false,context),
              bottomNavigatorBar(_currentIndex,1, Mdi.cart,false,context),
              bottomNavigatorBar(_currentIndex, 2, Mdi.shoppingOutline,false,context),
              bottomNavigatorBar(_currentIndex, 3, Mdi.accountSettings,false,context),
            ],
          ),
        ),
        body: SafeArea(
        child: _buildBody(constraints),
        )
      );
      }
    );
  }


 _buildBody(constraints){

      return Stack(
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
        
       );   
 }

}