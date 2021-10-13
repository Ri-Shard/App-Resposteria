
import 'package:appreposteria/src/controllers/order_controller.dart';
import 'package:appreposteria/src/model/cart_item_model.dart';
import 'package:appreposteria/src/model/order_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
      test('Guardar Pedido', () async{
    String response = "";
    OrderController orderController = new OrderController();
    List<CartItemModel> listacarrito = [];
    OrderModel order = new OrderModel();
    order.uid = "OHiMMe2Nh4YtVz24crHfUVvNITy2";
    order.name = "Deison";
    order.address ="Calle 20d # 3-12";
    order.date = "23/9/2021/21/33/20";
    order.dat = "2392021213320"; 
    order.delivery = "";
    order.deliveryname = "";
    order.status = "PEDIDO LISTO";
    order.total= "15000";
    order.cart = listacarrito;
      response = orderController.registerTest();
       expect(response, "Orden Guardada con exito");
  });
  
  test('Consultar Pedidos', () {
    OrderController orderController = new OrderController();
    List<OrderModel> pedidosReturn;
    List<OrderModel> pedidos;
    pedidosReturn = orderController.checkOrders();
    pedidos = pedidosReturn;
    expect(pedidos, pedidosReturn);
  });
      test('Modificar Pedido', () async{
        String response = "";
    OrderController orderController = new OrderController();
    List<CartItemModel> listacarrito = [];
    OrderModel order = new OrderModel();
    order.uid = "OHiMMe2Nh4YtVz2NITy2";
    order.name = "Deison";
    order.address ="Calle 20d # 3-12";
    order.date = "23/9/2021/21/33/20";
    order.dat = "2392021213320"; 
    order.delivery = "";
    order.deliveryname = "";
    order.status = "ENTREGADO";
    order.total= "15000";
    order.cart = listacarrito;
      response = orderController.updateUserOrder(order, order.status.toString());
       expect(response, "Orden modificada con exito");
  });
      test('Eliminar Pedido', () async{
        OrderController orderController = new OrderController();
    String response = "";
      String dat = "239202121";
      response = await orderController.deleteOrder(dat);
       expect(response, "Orden Borrada con exito");
  }); 
}