import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/errorDialog.dart';
import 'package:appreposteria/src/other/loadingDialog.dart';
import 'package:appreposteria/src/ui/auth/register_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  
  static Widget create(BuildContext context) => Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
{
    final TextEditingController _emailTextEditingController = TextEditingController();
    final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Iniciar Sesion", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20,),
                      Text("Accede a tu cuenta", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]
                      ),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                         makeInput(label: "Email",controller:_emailTextEditingController),
                         makeInput(label: "Contraseña", obscureText: true,controller:_passwordTextEditingController ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
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
                          _emailTextEditingController.text.isNotEmpty
                          && _passwordTextEditingController.text.isNotEmpty
                          ?loginUser() 
                          : showDialog(
                            context: context,
                            builder: (c)
                            {
                              return ErrorAlertDialog(message: "Por favor revisa los campos");
                            }
                            );
                        },                         color: AppColors.kCategorypinkColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("Iniciar Sesion", style: TextStyle(
                          fontWeight: FontWeight.w600, 
                          fontSize: 18
                        ),),
                      ),
                    ),
                  ),
              FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                      }, 
                      child :Text("¿No tienes cuenta?"+" Registrate", style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16
                         ),),                    
                      ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/login.png'),
                  fit: BoxFit.cover
                )
              ),
            )
          ],
        ),
      ),
    );

  }

  void loginUser() async
  {
    showDialog(
      context: context,
      builder:(c)
      {
        return LoadingAlertDialog(message: "Autenticando, Por Favor espere.....",);
      }
    );
  }

  Widget makeInput({label, obscureText = false,controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}