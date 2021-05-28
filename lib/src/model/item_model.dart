
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
   double? price;

  ProductModel(this.uid,this.description,this.image,this.ingredients,this.name,this.price);

  ProductModel.fromMap(Map<String, dynamic> data){
    uid = data[UID];
    image = data[IMAGE];
    name = data[NAME];
    description = data[DESCRIPTION];
    ingredients = data[INGREDIENTS];
    price = data[PRICE].toDouble();
  }

}