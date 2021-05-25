import 'package:equatable/equatable.dart';

class DeliveryModel extends Equatable {
  final String id;
  final String name;
  final String vehicle;

  DeliveryModel(this.id, this.name, this.vehicle,);

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'vehicle': vehicle,

    };
  }

  DeliveryModel.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        vehicle = data['vehicle'] as String;
}