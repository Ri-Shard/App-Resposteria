
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/ui/admin/admin_home_screen.dart';
import 'package:appreposteria/src/ui/admin/upload_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';

Widget bottomNavigatorBar(int _currentIndex ,int index, IconData icon){
    return GestureDetector(
      onTap: () {
       _currentIndex = index;
        switch (_currentIndex) {
          case 0:
           Get.offAll(AdminHomePage()); 
            break;
          case 1:
           Get.offAll(UploadProducts()); 
            break;
          case 2:
          // Get.offAll(); 
            break;
          case 3:
           //Get.offAll(); 
            break;
          default:
          Get.offAll(AdminHomePage()); 
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: index == _currentIndex ? AppColors.kCategorypinkColor : Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          child: Icon(
            icon,
            color: index == _currentIndex
                ? Colors.white
                : AppColors.kCategorypinkColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

