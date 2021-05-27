import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/errorDialog.dart';
import 'package:appreposteria/src/other/loadingDialog.dart';
import 'package:appreposteria/src/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


    final TextEditingController _nameTextEditingController = TextEditingController();
    final TextEditingController _emailTextEditingController = TextEditingController();
    final TextEditingController _passwordTextEditingController = TextEditingController();
    final TextEditingController _cPasswordTextEditingController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    String? emailValidator(String? value) {
    return (value == null || value.isEmpty) ? 'Campo Requerido' : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Campo Requerido';
    if (value.length < 6) return 'La contraseña debe tener al menos 6 digitos';
    if (_passwordTextEditingController.text != _cPasswordTextEditingController.text) return 'Las contraseñas no coinciden';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body:  Form(
              key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Registrarse", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 20,),
                    Text("Create una cuenta, es gratis", style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700]
                    ),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    makeInput(label: "Nombre",controller: _nameTextEditingController,validator: emailValidator),
                    makeInput(label: "Email",controller: _emailTextEditingController,validator: emailValidator),
                    makeInput(label: "Contraseña", obscureText: true,controller:_passwordTextEditingController, validator: passwordValidator),
                    makeInput(label: "Confirmar Contraseña", obscureText: true,controller: _cPasswordTextEditingController, validator: passwordValidator),
                  ],
                ),
                Container(
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
                     onPressed: () {uploadToStorage();}, 
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
                
               FlatButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },                       
                        child :Text("¿Ya tienes cuenta?"+" Inicia Sesion", style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16
                           ),),                    
                        ),
              ],
          ),
        ),
      ),
            )    
     
    );
  }

   uploadToStorage( ){    

   }
    
  Widget makeInput({label, obscureText = false, controller, validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextFormField(
          validator: validator,
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