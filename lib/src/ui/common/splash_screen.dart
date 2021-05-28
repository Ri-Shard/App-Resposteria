import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static Widget create(BuildContext context) => SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFFFF9494),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/welcome.png",height: 250.0, width: 250.0,),
              SizedBox(height:30.0),
              Text(
                "Aca va el loading... \nSi, el que no me ha pasado \nDuvan ",
                  style: TextStyle(color: Colors.white, fontSize: 30,fontFamily: "Signatra"),
                ),
            ],
          ),
        ),
        ),
        
      );
  }
}
