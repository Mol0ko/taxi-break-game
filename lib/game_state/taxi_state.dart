import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';

sealed class TaxiState implements Equatable {
  @override
  bool? get stringify => true;
}

class NoPassenger extends TaxiState {
  @override
  List<Object?> get props => [];
}

class PickingUpPassenger extends TaxiState {
  final int passengerId;

  PickingUpPassenger({required this.passengerId});

  @override
  List<Object?> get props => [passengerId];
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

  @override
  List<Object?> get props => [
        passengerId,
        destinationPoint,
        maxDeliveryTime,
      ];
}

class DisembarkingPassengerOnFailedDelivery extends TaxiState {
  final int passengerId;
  final Vector2 destinationPoint;

  DisembarkingPassengerOnFailedDelivery({
    required this.passengerId,
    required this.destinationPoint,
  });

  @override
  List<Object?> get props => [
        passengerId,
        destinationPoint,
      ];
}

class DisembarkingPassengerOnSuccessDelivery extends TaxiState {
  final int passengerId;
  final Vector2 destinationPoint;

  DisembarkingPassengerOnSuccessDelivery({
    required this.passengerId,
    required this.destinationPoint,
  });

  @override
  List<Object?> get props => [
        passengerId,
        destinationPoint,
      ];
}
