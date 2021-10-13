import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/delivery_model.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/general_appbar.dart';
import 'package:appreposteria/src/ui/admin/Delivery_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditDeliveryPage extends StatelessWidget {

  final DeliveryModel delivery;
  EditDeliveryPage({required this.delivery}); 
  final _formKey = GlobalKey<FormState>();

  int cont = 0;

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'El Nombre es Requerido'),
    MaxLengthValidator(20, errorText: 'Nombre muy largo, pruebe uno mas corto'),
    MinLengthValidator(2, errorText: 'Nombre muy corto')
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

  final numValidator = MultiValidator([
    RequiredValidator(errorText: 'El telefono de contacto es Requerido'),
    MaxLengthValidator(10, errorText: 'Numero muy largo, pruebe uno mas corto'),
    MinLengthValidator(10, errorText: 'Numero muy corto')
  ]);

  late double height, width;
  @override
  Widget build(BuildContext context) {
    deliveryController.name.text = delivery.name.toString();
    deliveryController.cedula.text = delivery.cedula.toString();
    deliveryController.phone.text = delivery.phone.toString();
    deliveryController.placa.text = delivery.placa.toString();
    deliveryController.vehiculo.text = delivery.vehiculo.toString();
    return Scaffold(
      appBar: generalAppbar("Editar Domiciliario", DomiciliariosPage()),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {

    return Form(
      key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: SingleChildScrollView(

              child: Column(
                children: <Widget>[
                  makeInputname(),
                  makeInputCC(),
                  makeInputTel(),
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
                    Get.offAll(()=>DomiciliariosPage());
                    updateToStorage();
                  },
                  color: AppColors.kCategorypinkColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Guardar",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),

            SizedBox(
              height: 20,
            ),
            TextButton(onPressed: (){
               Get.offAll(()=>DomiciliariosPage());
              deliveryController.deleteD(delivery.id.toString());
            }, child: Text("Eliminar Cuenta", style: TextStyle(color: Colors.red),)),

                ],
              ),
          ),
        ),
      );
  }
  updateToStorage() {
    if (_formKey.currentState?.validate() == true) {
         deliveryController.updateD(delivery.id.toString())();
      }else{
      Get.snackbar("Error", "Digite los campos");
    }
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

      Widget makeInputTel() {
    return Container(
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
            controller: deliveryController.phone,
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

























