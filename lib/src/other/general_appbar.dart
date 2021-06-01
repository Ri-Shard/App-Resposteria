import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget generalAppbar(String title, StatefulWidget sta)  {
    return AppBar(
          title: Text(title,  
                style: TextStyle(
                fontWeight: FontWeight.w800, 
                color: Colors.black,
                fontSize: 20)),
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () {
              Get.offAll(sta);
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
        );
  
}