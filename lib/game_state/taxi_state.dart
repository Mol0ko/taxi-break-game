sealed class TaxiState {}

class NoPassenger extends TaxiState {}

class PickingUpPassenger extends TaxiState {
  final int passengerId;

  PickingUpPassenger({required this.passengerId});
}

class DeliveringPassenger extends TaxiState {
  final int passengerId;

  DeliveringPassenger({required this.passengerId});
}

class DisembarkingPassenger extends TaxiState {
  final int passengerId;

  DisembarkingPassenger({required this.passengerId});
}
