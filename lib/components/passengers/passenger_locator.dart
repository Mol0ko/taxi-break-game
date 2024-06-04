import 'dart:async';

import 'package:flame/components.dart';
import 'package:taxi_break_game/components/passengers/passenger.dart';
import 'package:taxi_break_game/components/passengers/passenger_type.dart';
import 'package:taxi_break_game/components/taxi/taxi_body.dart';
import 'package:taxi_break_game/taxi_break_game.dart';
import 'package:taxi_break_game/taxi_break_game_state.dart';

class PassengerLocator extends Component {
  // SETTINGS
  static const double startPickingUpRadius = 72 / gameZoom;
  static const double pickUpRadius = 30 / gameZoom;
  final double _maxTaxiVelocityToTakePassenger = 0.2;
  // END SETTINGS

  final TaxiBody _taxi;
  final List<PassengerBody> _passengers = [];

  PassengerLocator({required TaxiBody taxi}) : _taxi = taxi;

  @override
  FutureOr<void> onLoad() async {
    // TODO: populate more passengers
    final passenger1 = PassengerBody(type: PassengerType.man3);
    _passengers.add(passenger1);
    await add(passenger1);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    for (final passenger in _passengers) {
      if (_taxi.position.distanceTo(passenger.position) < startPickingUpRadius &&
          _taxi.body.linearVelocity.length <= _maxTaxiVelocityToTakePassenger) {
        _startPickingUpPassenger(passenger);
      }
    }
    super.update(dt);
  }

  Future<void> _startPickingUpPassenger(PassengerBody passenger) async {
    TaxiBreakGameState.instance.startPickUp();
    await passenger.moveToTaxi(targetPosition: _taxi.position);
    _passengers.remove(passenger);
    remove(passenger);
    TaxiBreakGameState.instance.startDeliver();
  }
}
