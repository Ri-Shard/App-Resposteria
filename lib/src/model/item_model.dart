  
class ItemModel   {
  final String id;
  final String name;
  final String description;
  final String ingredients;
  final int price;

  final String? image;

  ItemModel(this.id, this.name, this.description, this.price, this.ingredients, {this.image});

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'price': price,
      'image': newImage ?? image,
    };
  }

  ItemModel.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        description = data['description'] as String,
        ingredients = data['ingredients'] as String,
        price = data['price'] as int,
        image = data['image'] as String?;
}