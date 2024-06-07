import 'package:flame/components.dart';

sealed class TaxiState {}

class NoPassenger extends TaxiState {}

class PickingUpPassenger extends TaxiState {
  final int passengerId;

  PickingUpPassenger({required this.passengerId});
}

class DeliveringPassenger extends TaxiState {
  final int passengerId;
  final Vector2 destinationPoint;
  final Duration maxDeliveryTime;

  DeliveringPassenger({
    required this.passengerId,
    required this.destinationPoint,
    required this.maxDeliveryTime,
  });
}

class DisembarkingPassengerOnFailedDelivery extends TaxiState {
  final int passengerId;
  final Vector2 destinationPoint;

  DisembarkingPassengerOnFailedDelivery({
    required this.passengerId,
    required this.destinationPoint,
  });
}

class DisembarkingPassengerOnSuccessDelivery extends TaxiState {
  final int passengerId;
  final Vector2 destinationPoint;

  DisembarkingPassengerOnSuccessDelivery({
    required this.passengerId,
    required this.destinationPoint,
  });
}
