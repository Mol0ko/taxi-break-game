import 'package:flame/components.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_type.dart';

class PassengerModel {
  final int id;
  final PassengerType type;
  final Vector2 spawnPoint;
  final Vector2 destinationPoint;
  final Duration maxDeliveryTime;

  PassengerModel({
    required this.type,
    required this.spawnPoint,
    required this.destinationPoint,
    required this.maxDeliveryTime,
  }) : id = DateTime.timestamp().millisecondsSinceEpoch;
}
