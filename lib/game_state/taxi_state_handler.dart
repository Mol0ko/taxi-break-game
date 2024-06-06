import 'dart:developer';

import 'package:flame/components.dart';
import 'package:taxi_break_game/components/passengers/passenger_locator.dart';
import 'package:taxi_break_game/components/taxi/taxi_body.dart';
import 'package:taxi_break_game/game_state/game_settings.dart';
import 'package:taxi_break_game/game_state/taxi_break_game_state.dart';
import 'package:taxi_break_game/game_state/taxi_state.dart';

class TaxiStateHandler extends Component {
  // SETTINGS
  final double _maxTaxiVelocityToTakePassenger = 0.2;
  // END SETTINGS

  final TaxiBreakGameState _gameState;
  final PassengerLocator _passengerLocator;
  final TaxiBody _taxi;

  TaxiStateHandler({
    required TaxiBreakGameState gameState,
    required PassengerLocator passengerLocator,
    required TaxiBody taxi,
  })  : _gameState = gameState,
        _passengerLocator = passengerLocator,
        _taxi = taxi {
    _gameState.stateStream.listen(_handleNewTaxiState);
  }

  @override
  void update(double dt) {
    final taxiState = _gameState.state;
    if (taxiState case NoPassenger()) {
      for (final passenger in _passengerLocator.passengers) {
        if (_taxi.position.distanceTo(passenger.position) < GameSettings.startPickingUpRadius &&
            _taxi.body.linearVelocity.length <= _maxTaxiVelocityToTakePassenger) {
          _gameState.startPickUp(passengerId: passenger.model.id);
        }
      }
    }
    super.update(dt);
  }

  Future<void> _handleNewTaxiState(TaxiState taxiState) async {
    log('New taxi state: ${taxiState.runtimeType}');
    switch (taxiState) {
      case NoPassenger():
        break;
      case PickingUpPassenger(:final passengerId):
        final passenger = _passengerLocator.passengers.firstWhere(
          (p) => p.model.id == passengerId,
        );
        await passenger.moveToTaxi(targetPosition: _taxi.position);
        _passengerLocator.remove(passenger);
        _gameState.startDeliver(
          passengerId: passengerId,
          destinationPoint: passenger.model.destinationPoint,
          maxDeliveryTime: passenger.model.maxDeliveryTime,
        );
        break;
      case DeliveringPassenger():
        break;
      case DisembarkingPassenger():
        break;
    }
  }
}