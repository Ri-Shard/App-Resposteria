import 'package:appreposteria/src/constants/controllers.dart';
import 'package:appreposteria/src/model/address_model.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/other/custom_text.dart';
import 'package:appreposteria/src/ui/store/order_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> with SingleTickerProviderStateMixin{
      List<CartItemModel>? cartlist = authController.myuser.cart!;
      TabController? _tabController;
       int? currentIndex;
       int? value;
        final _formKey = GlobalKey<FormState>();
        bool mostrar = false;
        int? long;
        RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final barrValidator = MultiValidator([
    RequiredValidator(errorText: 'El Nombre del barrio es Requerido'),
    MaxLengthValidator(20, errorText: 'Nombre del barrio muy largo, pruebe uno mas corto'),
    MinLengthValidator(2, errorText: 'Nombre del barrio muy corto')
  ]);
  final cityValidator = MultiValidator([
    RequiredValidator(errorText: 'El Nombre de la ciudad es Requerido'),
    MaxLengthValidator(20, errorText: 'Nombre de la ciudad muy largo, pruebe uno mas corto'),
    MinLengthValidator(2, errorText: 'Nombre de la ciudad muy corto')
  ]);

  final dirValidator = MultiValidator([
    RequiredValidator(errorText: 'La direccion es Requerida'),
    MaxLengthValidator(50, errorText: 'Direccion muy larga, pruebe una mas corta'),
    MinLengthValidator(10, errorText: 'direccion muy corta'),
    PatternValidator(r'(Autopista|Avenida|Avenida Calle|Avenida Carrera|Avenida|Carrera|Calle|Carrera|Circunvalar|Diagonal|Kilometro|Transversal|AUTOP|AV|AC|AK|CL|KR|CCV|DG|KM|TV)(\s)?([a-zA-Z]{0,15}|[0-9]{1,3})(\s)?[a-zA-Z]?(\s)?(bis)?(\s)?(Este|Norte|Occidente|Oeste|Sur)?(\s)?(#(\s)?[0-9]{1,2}(\s)?[a-zA-Z]?(\s)?(bis)?(\s)?(Este|Norte|Occidente|Oeste|Sur)?(\s)?(-)?(\s)?[0-9]{1,3}(\s)?(Este|Norte|Occidente|Oeste|Sur)?)?((\s)?(Agrupación|Altillo|Apartamento|Apartamento Sótano|Barrio|Bloque|Bodega|Cabecera Municipal|Callejón|Camino|Carretera|Casa|Caserio|Célula|Centro|Centro Comercial|Centro Urbano|Circular|Condominio|Conjunto|Consultorio|Corregimiento|Deposito|Deposito |Sótano|Edificio|Entrada|Esquina|Etapa|Finca|Garaje|Garaje Sótano|Grada|Inferior|Inspección de Policia|Interior|Kilometro|Local|Local Mezzanine|Local Sótano|Lote|Manzana|Manzanita|Mejora|Mezzanine|Módulo|Municipio|Núcleo|Oficina|Oficina Sótano|Parcela|Parcelación|Pasaje|Penthouse|Piso|Porteria|Predio|Principal|Puente|Quebrada|Salon|Sector|Semisótano|Suite|Supermanzana|Terraza|Torre|Troncal|Unidad|Urbanización|Vereda|Via|Zona|AGN|AL|APTO|AS|BR|BL|BG|CM|CLJ|CN|CT|CA|CAS|CEL|CE|CECO|CEUR|CIR|CDM|CONJ|CS|CO|DP|DS|ED|EN|ESQ|ET|FCA|GJ|GS|GR|INF|IP|IN|KM|LC|LM|LS|LT|MZ|MZTA|MJ|MN|MD|MUN|NCO|OF|OS|PA|PCN|PSJ|PH|PI|PT|PD|PPAL|PN|QDA|SA|SEC|SS|SU|SMZ|TZ|TO|TRL|UN|URB|VDA|VIA|ZN)?(\s)?[1-9][0-9]{0,3})', errorText: 'Error, direccion invalida')

  ]);


@override
void initState() { 
  super.initState();
  long = addressController.checkAddress().length;
   _tabController = TabController(length: 2, vsync: this); 
}

@override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
    void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
    setState(() {
      initState();
    });
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
     return 
        Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0 ,title: Text("Direcciones",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center, )),
         body:  
         SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,            
            header: WaterDropHeader(),         
            controller: _refreshController,
           onRefresh: _onRefresh,
           onLoading:_onLoading,
            child: TabBarView(
            controller: _tabController, 
            children: [
            ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 5,
                ),
                long == 0 && mostrar == false?
                Container(                             
                    child: imageMessage()                
                )
                :  
                Column(
                  children: [
                    SizedBox(height:20),
                    CustomText(text: "Seleccione una direccion",weight: FontWeight.bold,size: 20),
                    SizedBox(height:20),
                    Column(    
                        children:           
                            addressController.addresslist.map((element) => itemWidget(element))
                            .toList(),                     
                      ),
                  SizedBox(
                  height: 50
                    ),
                  Text("Deslice para Añadir",
                      style: TextStyle(fontWeight : FontWeight.bold,fontSize: 18 )),
                  SizedBox(
                  height: 20
                    ),
                  Center(child: Icon(Mdi.arrowExpandLeft,color: AppColors.kCategorypinkColor, size: 40,),)   ,
                    SizedBox(
                     height: 20
                    ),
                  ],
                ),
                     ],
            ),
            form(),
            ],),
         )

       );
  }
  imageMessage(){
    return Column(
                  children: [                
                    Image(image: AssetImage("images/Directions.png")),
                    SizedBox(
                      height: 20
                    ),
                    Text("No hay Direcciones Añadidas",
                        style: TextStyle(fontWeight : FontWeight.bold,fontSize: 25 )),
                     SizedBox(
                      height: 20
                       ),
                    Text("Deslice para Añadir",
                        style: TextStyle(fontWeight : FontWeight.bold,fontSize: 18 )),
                      SizedBox(
                      height: 20
                       ),
                     Center(child: Icon(Mdi.arrowExpandLeft,color: AppColors.kCategorypinkColor, size: 40,),)  
                        ]
                );
  }
    Widget itemWidget(AddressModel addressModel)
    {
     return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          addressController.deleteAddress(addressModel.date);
          initState();
          _onRefresh();
        });
      }, 
                  background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Icon(Mdi.trashCan),
                ],
              ),
            ),
      child: Card(
        color: AppColors.kCategorypinkColor,
        child: Column(
          children: [
            Row(
              children: [
                Column(                
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                   
                       GestureDetector(
                         onTap: (){
                                   AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.SUCCES,
                                    showCloseIcon: true,
                                    title: 'Pedido Realizado',                                  
                                    btnOkOnPress: () {
                                      addressController.addressModel=addressModel; 
                                      Get.offAll(()=>OrderScreen());
                                      orderController.addOrderToFirestore(authController.myuser.uid.toString());
                                      cartController.clearCart();
                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDissmissCallback: (type) {
                                      debugPrint('Dialog Dissmiss from callback $type');
                                    })
                                  ..show();
                         },
                         child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: Get.width *0.8,
                          child: Table(
                            children: [      
                              TableRow(
                                children: [
                                   Text(
                                    "Direccion:",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                   ),
                                   Text(addressModel.address.toString(),
                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                                   ),
                                ]
                              ),                      
                              TableRow(
                                children: [
                                   Text(
                                    "Barrio:",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                   ),
                                   Text(addressModel.barrio.toString()),
                                ]
                              ),
                              TableRow(
                                children: [
                                   Text(
                                    "Ciudad:",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                   ),
                                   Text(addressModel.city.toString()),
                                ]
                              ),
                            ]
                          ),
                      ),
                       ),
                    
                  ],
                )
              ],
            ),
          ],
        ),
      )
     );
    }



      Widget form(){                                                                                      
            return 
            Form(
            key: _formKey,
            child: ListView(
                children: [Column(
                  children: [ Column(
                    children: <Widget>[
                      Text("Agregar Dirección", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 10,),
                      Text("Digita los campos necesarios", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]
                      ),),
                    ],
                  ),
                   SizedBox(height: 10,),
                   Column(
                    children: <Widget>[
                      makeInputDire(),
                      makeInputBarr(),
                      makeInputCiu(),
                    ],
                  ),
                  SizedBox(height: 20,),
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
                          minWidth: 200,
                          height: 60,
                            onPressed: () async{
                              setState(() {                      
                              if(_formKey.currentState?.validate() == true){
                              addressController.addAddressToFirestore(authController.myuser.uid.toString());                              
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.SUCCES,
                                    showCloseIcon: true,
                                    title: 'Guardado',
                                    desc:
                                        'Direccion guardada Con exito',
                                    btnOkOnPress: () {
                                                  showBarModalBottomSheet(
                                                    context: context,
                                                    builder: (context) => Container(
                                                      color: Colors.white,
                                                      child: AddressScreen(),
                                                    ),
                                                  );                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDissmissCallback: (type) {
                                      debugPrint('Dialog Dissmiss from callback $type');
                                    })
                                  ..show();
                              }
                              });
                            }, 
                          color: AppColors.kCategorypinkColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text("Agregar", style: TextStyle(
                            fontWeight: FontWeight.w600, 
                            fontSize: 18
                          ),),
                        ),
                  ),
                  Image(image: AssetImage("images/Directions.png"),width: 300,),
                ]
                ),]
              ),
            );
      }

Widget card (AddressModel address){
  return Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Expanded(
              child: Wrap(
                direction: Axis.vertical,
                children: [
                    CustomText(
                        text: address.name,
                      ),
                    CustomText(
                        text: address.barrio,
                      ),
               
                    CustomText(
                        text: authController.myuser.phone,
                      ),
                    CustomText(
                        text: address.city,
                      ),
                ],
              )),
        ],
      );
}
    Widget makeInputDire() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Direccion', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
          ),),
          SizedBox(height: 5,),
          TextFormField(      
          autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: dirValidator,
            controller: addressController.address,
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
    Widget makeInputBarr() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Barrio', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
          ),),
          SizedBox(height: 5,),
          TextFormField(    
            autovalidateMode: AutovalidateMode.onUserInteraction,      
            validator: barrValidator,
            controller: addressController.barrio,
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
    Widget makeInputCiu() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Ciudad', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
          ),),
          SizedBox(height: 5,),
          TextFormField( 
            autovalidateMode: AutovalidateMode.onUserInteraction,               
            validator: cityValidator,
            controller: addressController.city,
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