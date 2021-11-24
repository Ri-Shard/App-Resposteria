
class ProductModel{
  static const UID = "uid";
  static const IMAGE = "image";
  static const NAME = "name";
  static const DESCRIPTION = "description";
  static const INGREDIENTS = "ingredients";
  static const PRICE = "price";

   String? uid;
   String? image;
   String? name; 
   String? description;
   String? ingredients;
   int? price;

  ProductModel(this.uid,this.description,this.image,this.ingredients,this.name,this.price);

  ProductModel.fromMap(Map<String, dynamic> data){
    uid = data[UID];
    image = data[IMAGE];
    name = data[NAME];
    description = data[DESCRIPTION];
    ingredients = data[INGREDIENTS];
    price = int.parse(data[PRICE]);
  }
      Map<String, dynamic> toMap( product){
    return {
      "image" : product.image,
      "name" : product.name,
      "quantity" : 1,
      "cost" :  product.price,
      "price" : product.price,
      "productId" : product.uid , 
      "description":product.description,
      "ingredients":product.ingredients
    };
  }

}