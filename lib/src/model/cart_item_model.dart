class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";
  static const PRODUCT_ID = "productId";


  String? id;
  String? image;
  String? name;
  int quantity;
  double? cost;
   String? productId;
   double? price;



  CartItemModel({this.productId, this.id, this.image, this.name, required this.quantity, this.cost});

 CartItemModel fromMap(Map<String, dynamic> data){
    CartItemModel cart = CartItemModel(quantity: 1);
    cart.id = data[ID];
    cart.image = data[IMAGE];
    cart.name = data[NAME];
    cart.quantity = data[QUANTITY];
    cart.cost = data[COST].toDouble();
    cart.productId = data[PRODUCT_ID];
    cart.price = data[PRICE].toDouble();

    return cart;
  }

  Map toJson() => {
    ID: id, 
    PRODUCT_ID: productId,
    IMAGE: image, 
    NAME: name,
    QUANTITY: quantity,
    COST: price! * quantity,
    PRICE: price 
  };

}