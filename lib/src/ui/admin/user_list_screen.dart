
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/user_model.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/ui/admin/admin_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Listado Usuarios",  
                style: TextStyle(
                fontWeight: FontWeight.w800, 
                color: Colors.black,
                fontSize: 20)),
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () {
              Get.offAll(()=>AdminHomePage());
              
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),

        ),
      body: ListView(
              children: [
 
                Column(
                  children: [
                    Column(    
                        children:           
                            authController.userlist.map((element) => itemWidget(element))
                            .toList(),                     
                      ),

                  ],
                ),
                     ],
      ),
    );
  }

    Widget itemWidget(MyUser user)
    {
     return Card(
        color: AppColors.kCategorypinkColor,
        child: Column(
          children: [
            Row(
              children: [
                Column(                
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                   
                       GestureDetector(
                         onTap: (){                           
                         },
                         child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: Get.width *0.8,
                          child: Table(
                            children: [      
                              TableRow(
                                children: [
                                   Text(
                                    "Nombre:",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                   ),
                                   Text(user.name.toString(),                                  
                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                                   ),
                                ]
                              ),                      
                              TableRow(
                                children: [
                                   Text(
                                    "Email:",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                   ),
                                   Text(user.email.toString()),
                                ]
                              ),
                              TableRow(
                                children: [
                                   Text(
                                    "Uid:",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                   ),
                                   Text(user.uid.toString()),
                                ]
                              ),
                            ]
                          ),
                      ),
                       ),
                    
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }
}