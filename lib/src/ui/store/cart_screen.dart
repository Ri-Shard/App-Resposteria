import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/custom_buttom.dart';
import 'package:appreposteria/src/other/custom_text.dart';
import 'package:appreposteria/src/ui/store/address_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';



class ShoppingCartWidget extends StatefulWidget {
    
  @override
  _ShoppingCartWidgetState createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
    late double height, width;
@override
void initState() { 
  super.initState();
  cartController.checkCart();
}
int cartPrice = 0;
  @override
  Widget build(BuildContext context) {
     return       StreamBuilder (
         stream: firebaseFirestore.collection("users").doc(auth.currentUser!.uid).collection("cart").snapshots(),
         builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
           if(snapshot.data !=null){
            int auxi = 0;
             for (var item in snapshot.data!.docs) {
               auxi += int.parse(item.get("cost").toString());
             }
             cartPrice=auxi;
           }
           return snapshot.data == null? Text("sada"):Scaffold(
       appBar: AppBar(
      leading: Icon(Mdi.cart, color: Colors.black, size: 30,),
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Column(
            children: [
              Text(
                "Carrito",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "${cartController.cartlist.length} items",
                style: Theme.of(context).textTheme.caption,
              ), 
            ]
          ),
            SizedBox(
              width: 40,
            ),

                 Text("Total: "+"\$"+ cartPrice.toString(),
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.end,),
            
            IconButton(onPressed: (){ cartController.clearCart(); cartController.checkCart();},
            icon: Icon(Mdi.trashCan, color: Colors.black,))       
        ],
      ),
    ),
       body: 
ListView.builder(
             itemCount: snapshot.data!.docs.length,
             itemBuilder: (_,index){
             return ListTile(
               leading: Container(width:80 ,height:80 ,color: Colors.pink,
               child: Image.network(snapshot.data!.docs[index].get("image"),fit:BoxFit.cover,),),
               title: Text(snapshot.data!.docs[index].get("name")),
               subtitle: Row(
                 children: [
                       IconButton(
                          icon: Icon(
                              Icons.chevron_left),
                          onPressed: () {
                          CartItemModel aux = CartItemModel(productId: snapshot.data!.docs[index].get("productId"),cost:snapshot.data!.docs[index].get("cost"),image: snapshot.data!.docs[index].get("image"),name: snapshot.data!.docs[index].get("name"),quantity: snapshot.data!.docs[index].get("quantity"),price:snapshot.data!.docs[index].get("price"));
                          cartController.decreaseQuantity(aux);
           //               cartPrice = cartController.cartTotalPrice().toString();

                          }),
                      Padding(
                        padding:
                        const EdgeInsets.all(
                            8.0),
                        child: CustomText(
                          text: snapshot.data!.docs[index].get("quantity").toString()
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons
                              .chevron_right),
                          onPressed: () {
                          CartItemModel aux = CartItemModel(productId: snapshot.data!.docs[index].get("productId"),cost:snapshot.data!.docs[index].get("cost"),image: snapshot.data!.docs[index].get("image"),name: snapshot.data!.docs[index].get("name"),quantity: snapshot.data!.docs[index].get("quantity"),price: snapshot.data!.docs[index].get("price"));
                          cartController.increaseQuantity(aux);  
                          //cartPrice = cartController.cartTotalPrice().toString();                        
                          }),
                 ],
               ),
               trailing: Text(snapshot.data!.docs[index].get("cost").toString(),style: TextStyle(fontWeight:FontWeight.bold ),),
             );
           }),
           
       bottomNavigationBar: _bottom(),
           );
           }
     );
  }



/*
            Container(                             
                child: Column(
                  children: [
                    Image(image: AssetImage("images/empty_cart.png")),
                    Text("Carrito Vacio",
                        style: TextStyle(fontWeight : FontWeight.bold,fontSize: 25 )),]
                ),
                
            ) */
  Widget _bottom(){
       return Container(
         width: 1,
         height: 60,
              padding: EdgeInsets.only(top:0, left: 10,right: 10,bottom: 10),
              child: CustomButton(            
                  text: "Proceder a Pedir", onTap: () {
                    if (cartController.cartlist.length == 0) {
                                                                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        title: 'UPS',
                        desc:
                          'No puedes pedir con un carrito Vacio',
                        btnOkOnPress: () {
                    
                        },
                        btnOkColor: AppColors.kCategorypinkColor)
                      ..show();
                    }else{
                                                                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.NO_HEADER,
                        title: 'Ahora, Elige tu direccion',
                        desc:
                          'Seras Redirigido',
                        btnOkOnPress: () {
                        
                            showBarModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                color: Colors.white,
                                child: AddressScreen() ,
                              ),
                            );
                        },
                        btnOkColor: AppColors.kCategorypinkColor)
                      ..show();
                    }
                  })
            );
  }

}
