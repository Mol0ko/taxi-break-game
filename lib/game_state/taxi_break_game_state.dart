import 'dart:async';

import 'package:flame/components.dart';
import 'package:taxi_break_game/game_state/taxi_state.dart';

class TaxiBreakGameState {
  int _passengersDelivered = 0;
  int get passengersDelivered => _passengersDelivered;

  TaxiState _state = NoPassenger();
  TaxiState get state => _state;

  final StreamController<TaxiState> _stateStreamController =
      StreamController<TaxiState>.broadcast();
  Stream<TaxiState> get stateStream => _stateStreamController.stream;

  static final TaxiBreakGameState instance = TaxiBreakGameState();

  TaxiBreakGameState() {
    _stateStreamController.add(_state);
  }

  void startPickUp({required int passengerId}) {
    _state = PickingUpPassenger(passengerId: passengerId);
    _stateStreamController.add(_state);
  }

  void startDeliver({
    required int passengerId,
    required Vector2 destinationPoint,
    required Duration maxDeliveryTime,
  }) {
    _state = DeliveringPassenger(
      passengerId: passengerId,
      destinationPoint: destinationPoint,
      maxDeliveryTime: maxDeliveryTime,
    );
    _stateStreamController.add(_state);
  }

  void startDisembarking() {
    if (_state case DeliveringPassenger(:final passengerId)) {
      _state = DisembarkingPassenger(passengerId: passengerId);
      _stateStreamController.add(_state);
    } else {
      throw StateError('Disembarking not started, previous state is not DeliveringPassenger');
    }
  }

  void disembarkingEnded() {
    _state = NoPassenger();
    _stateStreamController.add(_state);
    _passengersDelivered++;
  }
}
