import 'dart:async';

import 'package:taxi_break_game/game_state/taxi_state.dart';

class TaxiBreakGameState {
  int _passengersDelivered = 0;
  int get passengersDelivered => _passengersDelivered;

  TaxiState _state = NoPassenger();
  TaxiState get state => _state;

  final StreamController<TaxiState> _stateStreamController = StreamController<TaxiState>();
  Stream<TaxiState> get stateStream => _stateStreamController.stream;

  static final TaxiBreakGameState instance = TaxiBreakGameState();

  TaxiBreakGameState() {
    _stateStreamController.add(_state);
  }

  void startPickUp({required int passengerId}) {
    _state = PickingUpPassenger(passengerId: passengerId);
    _stateStreamController.add(_state);
  }

  void startDeliver({required int passengerId}) {
    _state = DeliveringPassenger(passengerId: passengerId);
    _stateStreamController.add(_state);
  }

  void startDisembarking({required int passengerId}) {
    _state = DisembarkingPassenger(passengerId: passengerId);
    _stateStreamController.add(_state);
  }

  void disembarkingEnded() {
    _state = NoPassenger();
    _stateStreamController.add(_state);
    _passengersDelivered++;
  }
}
