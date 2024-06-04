import 'dart:async';
import 'dart:developer';

class TaxiBreakGameState {
  int _passengersDelivered = 0;
  int get passengersDelivered => _passengersDelivered;

  TaxiState _state = TaxiState.noPassenger;
  TaxiState get state => _state;

  final StreamController<TaxiState> _stateStreamController = StreamController<TaxiState>();
  Stream<TaxiState> get stateStream => _stateStreamController.stream;

  static final TaxiBreakGameState instance = TaxiBreakGameState();

  TaxiBreakGameState() {
    _stateStreamController.add(_state);
    stateStream.listen((event) {
      log('Taxi state: $event');
    });
  }

  void startPickUp() {
    _state = TaxiState.pickingUpPassenger;
    _stateStreamController.add(_state);
  }

  void startDeliver() {
    _state = TaxiState.deliveringPassenger;
    _stateStreamController.add(_state);
  }

  void startDisembarking() {
    _state = TaxiState.disembarkingPassenger;
    _stateStreamController.add(_state);
  }

  void disembarkingEnded() {
    _state = TaxiState.noPassenger;
    _stateStreamController.add(_state);
    _passengersDelivered++;
  }
}

enum TaxiState {
  noPassenger,
  pickingUpPassenger,
  deliveringPassenger,
  disembarkingPassenger,
}
