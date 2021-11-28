import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/constants/firebase.dart';
import 'package:appreposteria/src/other/bottom_bar_User.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class EditUserPage extends StatefulWidget {
  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();
bool? q = false;
    final passwordValidator = MultiValidator([
    MinLengthValidator(6, errorText: 'Minimo 6 digitos'),
    MaxLengthValidator(15, errorText: 'Maximo 15 digitos'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'El Email es Requerido'),
    MaxLengthValidator(50, errorText: 'Email muy largo, pruebe uno mas corto'),
    EmailValidator(errorText: 'Ingresar un Email valido')
  ]);
  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'El Nombre es Requerido'),
    MinLengthValidator(3, errorText: 'Nombre minimo de 3 letras'),
    MaxLengthValidator(15, errorText: 'Nombre muy largo'),
  ]);
  final numValidator = MultiValidator([
    RequiredValidator(errorText: 'El telefono de contacto es Requerido'),
    MaxLengthValidator(10, errorText: 'Numero muy largo, pruebe uno mas corto'),
    MinLengthValidator(10, errorText: 'Numero muy corto')
  ]);
  String? confirmPassValidator(String? value) {
    if (value!.length < 6) return 'Debe tener al menos 6 digitos';
    if (authController.password.text != _cPasswordTextEditingController.text)
      return 'Las contraseñas no coinciden';
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    authController.name.text = authController.myuser.name.toString();
    authController.lastname.text = authController.myuser.lastname.toString();
    authController.email.text = authController.myuser.email.toString();
    authController.phone.text = authController.myuser.phone.toString();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              authController.clearControllers();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(children: [
          Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Modificar Informacion",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Puedes Modificar la informacion a Continuacion: ",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                                        SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    makeInputName(),
                    makeInputLName(),
                    makeInputEmail(),
                    Column(                      
                    children: [Text("Desea modificar la contraseña?"),
                    Checkbox(  
                      checkColor: Colors.greenAccent,  
                      activeColor: Colors.red,  
                      value: q,  
                      onChanged: (bool? valu) {  
                        setState(() {  
                          this.q = valu;  
                        });  
                      },  
                    ),  
                      ],
                    ),
                    q == true ?
                    Column(                                     
                      children: [
                    makeInputPass(),
                    makeInputConfirmPass(),
                      ],
                    )                    :
                    Container()
                    ,
                    makeInputTel(),
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
                      )),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      updateToStorage();
                      Get.offAll(()=>BottomBarUser());
                    },
                    color: AppColors.kCategorypinkColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Guardar",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 20)
              ]),
            ),
            key: _formKey,
          )
        ]));
  }

  updateToStorage() {
    if (_formKey.currentState?.validate() == true) {
      authController.updateUserDat(auth.currentUser);
    }else{
      Get.snackbar("Error", "Digite los campos");
    }
  }

  Widget makeInputConfirmPass() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Confirmar Nueva Contraseña",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: confirmPassValidator,
          controller: _cPasswordTextEditingController,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget makeInputPass() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Nueva Contraseña",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: passwordValidator,
          controller: authController.password,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget makeInputName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Nombre",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: nameValidator,
          controller: authController.name,
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
  Widget makeInputLName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Apellido",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: nameValidator,
          controller: authController.lastname,
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget makeInputEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Email",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: emailValidator,
          controller: authController.email,
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
    Widget makeInputTel() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Telefono', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
          ),),
          SizedBox(height: 5,),
          TextFormField(   
            autovalidateMode: AutovalidateMode.onUserInteraction,                      
             keyboardType: TextInputType.number,
            validator: numValidator,
            controller: authController.phone,
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
          SizedBox(height: 5,),
        ],
      ),
    );
  }
}
