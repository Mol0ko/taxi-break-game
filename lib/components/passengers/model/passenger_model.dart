import 'package:flame/components.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_type.dart';

class PassengerModel {
  final int id;
  final PassengerType type;
  final Vector2 spawnPoint;
  final Vector2 destinationPoint;
  final Duration maxDeliveryTime;

  PassengerModel({
    required this.id,
    required this.type,
    required this.spawnPoint,
    required this.destinationPoint,
    required this.maxDeliveryTime,
  });

  factory PassengerModel.fromMap(Map<String, dynamic> map) => PassengerModel(
        id: map['id'] as int,
        type: (map['type'] as String).toPassengerType(),
        spawnPoint:
            (map['spawnPoint'] as List).cast<num>().map((e) => e.toDouble()).toList().toVector2(),
        destinationPoint: (map['destinationPoint'] as List)
            .cast<num>()
            .map((e) => e.toDouble())
            .toList()
            .toVector2(),
        maxDeliveryTime: Duration(seconds: map['maxDeliveryTimeSec'] as int),
      );
}

extension Vector2FromJson on List<double> {
  Vector2 toVector2() => Vector2(this[0], this[1]);
}

extension PassengerTypeFromString on String {
  PassengerType toPassengerType() {
    switch (this) {
      case 'man1':
        return PassengerType.man1;
      case 'man2':
        return PassengerType.man2;
      case 'man3':
        return PassengerType.man3;
      default:
        return PassengerType.man3;
    }
  }
}
