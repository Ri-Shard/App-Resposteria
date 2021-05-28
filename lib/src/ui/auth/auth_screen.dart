import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/ui/auth/login_screen.dart';
import 'package:appreposteria/src/ui/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class AuthenticScreen  extends StatelessWidget {
  
  static Widget create(BuildContext context) => AuthenticScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Bienvenido", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),),
                  SizedBox(height: 20,),
                  Text("Dentro de poco podrás disfrutar de nuestros servicios. Por favor, verifique su identidad ", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15
                  ),),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/Autentication.png')
                  )
                ),
              ),
              Column(
                children: <Widget>[
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("Iniciar Sesion", style: TextStyle(
                      fontWeight: FontWeight.w600, 
                      fontSize: 18
                    ),),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(top: 2, left: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      color: AppColors.kCategorypinkColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("Registrarse", style: TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 18
                      ),),
                    ),
                    
                  ),   
                  
/* 
                    FlatButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminSignInPage())),
                      icon: (Icon(Icons.nature_people,color: AppColors.kCategorypinkColor)),
                      label: Text("Soy Administrador", style: TextStyle(color: AppColors.kCategorypinkColor,fontWeight: FontWeight.bold),),
                    ), */
                    
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}