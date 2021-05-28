import 'package:appreposteria/src/other/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static Widget create(BuildContext context) => SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Material(child: Container(
        color: AppColors.kCategorypinkColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/welcome.png",height: 250.0, width: 250.0,),
              SizedBox(height:30.0),
              Text(
                "Aca va el loading...",
                  style: TextStyle(color: Colors.white, fontSize: 30,fontFamily: "Signatra"),
                ),
            ],
          ),
        ),
        ));
  }

}
