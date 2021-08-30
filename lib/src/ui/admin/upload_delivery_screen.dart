import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/general_appbar.dart';
import 'package:appreposteria/src/ui/admin/Delivery_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class UploadDeliveryScreen extends StatefulWidget {
  UploadDeliveryScreen({Key? key}) : super(key: key);

  @override
  _UploadDeliveryScreenState createState() => _UploadDeliveryScreenState();
}

class _UploadDeliveryScreenState extends State<UploadDeliveryScreen> {
  final _formKey = GlobalKey<FormState>();
  int cont = 0;
  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'El Nombre es Requerido'),
    MaxLengthValidator(20, errorText: 'Nombre muy largo, pruebe uno mas corto'),
    MinLengthValidator(2, errorText: 'Nombre muy corto')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'El Email es Requerido'),
    MaxLengthValidator(50, errorText: 'Email muy largo, pruebe uno mas corto'),
    EmailValidator(errorText: 'Ingresar un Email valido')
  ]);

  final ccValidator = MultiValidator([
    RequiredValidator(errorText: 'La cedula es Requerida'),
    MaxLengthValidator(10, errorText: 'Numero de cedula invalido'),
    MinLengthValidator(7, errorText: 'Numero de cedula invalido')
  ]);

  final vehiValidator = MultiValidator([
    RequiredValidator(errorText: 'La Marca del vehiculo es Requerida'),
    MaxLengthValidator(10, errorText: 'Cantidad de caracteres excedidos'),
    MinLengthValidator(4, errorText: 'Pocos caracteres')
  ]);
  final placValidator = MultiValidator([
    RequiredValidator(errorText: 'La Placa del vehiculo es Requerida'),
    MaxLengthValidator(7, errorText: 'Cantidad de caracteres excedidos'),
    MinLengthValidator(6, errorText: 'Pocos caracteres'),
  ]);
  final placNValidator = MultiValidator([
    RequiredValidator(errorText: 'La Placa del vehiculo es Requerida'),
    MaxLengthValidator(3, errorText: 'Cantidad de caracteres excedidos'),
    MinLengthValidator(3, errorText: 'Pocos caracteres'),
  ]);

  late double height, width;
@override
  void initState() {
    super.initState();
    deliveryController.clearControllers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppbar("Agregar Domiciliario", DomiciliariosPage()),
      body: body(),
    );
  }

  Widget body() {
    return Form(
      key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 120,
          width: double.infinity,
          child: SingleChildScrollView(

              child: Column(
                children: <Widget>[
                  makeInputname(),
                  makeInputCC(),
                  makeInputEmail(),
                  makeInputVehi(),
                  makeInputPlac(), 
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
                  onPressed: () async {
                    deliveryController.register();
                  },
                  color: AppColors.kCategorypinkColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Agregar",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
                ],
              ),
              

              

          ),
        ),
      );
  }

  Widget makeInputname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nombre',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: nameValidator,
          controller: deliveryController.name,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget makeInputCC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cedula',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          validator: ccValidator,
          controller: deliveryController.cedula,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget makeInputEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: emailValidator,
          controller: deliveryController.email,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget makeInputVehi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Vehiculo',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: vehiValidator,
          controller: deliveryController.vehiculo,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }


  Widget makeInputPlac() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Placa',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(          
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: placValidator,
          controller: deliveryController.placa,
          onChanged: (t) {


            if(cont < t.length){
              if(t.length == 3 ){              
              t = t + '-'; 
              deliveryController.placa.text = t ;
              deliveryController.placa.selection = TextSelection.collapsed(offset: deliveryController.placa.text.length);
            }
            }
            if(cont-1 == t.length && t.length > 3 && !t.contains('-')){
              
              String aux = t.substring(3);
              t = t.substring(0,3)+'-'+aux;
             deliveryController.placa.text = t ;
              deliveryController.placa.selection = TextSelection.collapsed(offset: deliveryController.placa.text.length);
            }
            cont = t.length;
 

          } ,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }


}
