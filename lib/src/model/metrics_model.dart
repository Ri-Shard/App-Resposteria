import 'package:cloud_firestore/cloud_firestore.dart';

class MetricsModel {

  static const TOTALVENDIDO = "totalvendido";
  static const PRODUCTOMASVENDIDO = "productomasvendido";
  static const CLIENTEMASCOMPRA = "clientemascompra";
  static const GANANCIASEMANA = "gananciasemana";
  static const DOMIMASPEDIDOS = "domimaspedidos";  
  static const CANTIDADPRODUCTOSVENDIDOS = "cantidadproductosvendidos";  

  String? totalvendido;
  String? productomasvendido;
  String? clientemascompra;
  String? gananciasemana;
  String? domimaspedidos;
  String? cantidadproductosvendidos;


MetricsModel({this.cantidadproductosvendidos,this.totalvendido,this.clientemascompra,this.domimaspedidos,this.gananciasemana,this.productomasvendido });


  MetricsModel fromSnapshot(DocumentSnapshot snapshot){
    MetricsModel metrics = MetricsModel();
    metrics.totalvendido = snapshot[TOTALVENDIDO];
    metrics.productomasvendido = snapshot[PRODUCTOMASVENDIDO];
    metrics.clientemascompra = snapshot[CLIENTEMASCOMPRA];
    metrics.gananciasemana = snapshot[GANANCIASEMANA];
    metrics.domimaspedidos = snapshot[DOMIMASPEDIDOS];
    metrics.cantidadproductosvendidos = snapshot[CANTIDADPRODUCTOSVENDIDOS];
    
    return metrics;
  }

  MetricsModel.fromMap(Map<String, dynamic> data){
    totalvendido = data[TOTALVENDIDO];
    productomasvendido = data[PRODUCTOMASVENDIDO];
    clientemascompra= data[CLIENTEMASCOMPRA];
    gananciasemana = data[GANANCIASEMANA];
    domimaspedidos = data[DOMIMASPEDIDOS];
    cantidadproductosvendidos = data[CANTIDADPRODUCTOSVENDIDOS];
  }
  
  Map toJson() => {
  
"totalvendido":totalvendido,
"productomasvendido":productomasvendido,
"clientemascompra":clientemascompra,
"gananciasemana":gananciasemana,
"domimaspedidos":domimaspedidos,
"cantidadproductosvendidos":cantidadproductosvendidos
  };

}