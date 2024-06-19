import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:taxi_break_game/components/environment/destination_circle.dart';
import 'package:taxi_break_game/components/passengers/passenger_locator.dart';
import 'package:taxi_break_game/components/taxi/delivery_arrow.dart';
import 'package:taxi_break_game/components/taxi/taxi_body.dart';
import 'package:taxi_break_game/game_state/game_settings.dart';
import 'package:taxi_break_game/game_state/taxi_break_game_state.dart';
import 'package:taxi_break_game/game_state/taxi_state.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class TaxiStateHandler extends Component with HasGameReference<TaxiBreakGame> {
  // SETTINGS
  final double _maxTaxiVelocityToTakePassenger = 0.2;
  // END SETTINGS

  final TaxiBreakGameState _gameState;
  final PassengerLocator _passengerLocator;
  final TaxiBody _taxi;
  final _deliveryArrow = DeliveryArrow();

  Component? _destinationArea;
  Joint? _taxiPassengerJoint;

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
      _updatePickUpPassenger(dt);
    } else if (taxiState case DeliveringPassenger(:final destinationPoint)) {
      _updateDeliveringPassenger(dt, destinationPoint: destinationPoint);
    }
    super.update(dt);
  }

  void _updatePickUpPassenger(double dt) {
    for (final passenger in _passengerLocator.passengers) {
      if (_taxi.position.distanceTo(passenger.position) < GameSettings.startPickingUpRadius &&
          _taxi.body.linearVelocity.length <= _maxTaxiVelocityToTakePassenger) {
        _gameState.startPickUp(passengerId: passenger.model.id);
      }
    }
  }

  void _updateDeliveringPassenger(double dt, {required Vector2 destinationPoint}) {
    if (_taxi.position.distanceTo(destinationPoint) < GameSettings.destinationRadius &&
        _taxi.body.linearVelocity.length <= _maxTaxiVelocityToTakePassenger) {
      _gameState.startDisembarkingOnSuccessDelivery();
    }
    _deliveryArrow.angle = _taxi.position.angleTo(destinationPoint);
  }

  Future<void> _handleNewTaxiState(TaxiState taxiState) async {
    log('New taxi state: ${taxiState.runtimeType}\n${taxiState.props.join('\n')}');
    switch (taxiState) {
      case NoPassenger():
        game.world.controlsDisabled = false;
        _passengerLocator.enablePassengersPickUp();
        break;
      case PickingUpPassenger(:final passengerId):
        game.world.controlsDisabled = true;
        _taxi.currentDragDelta = Vector2.zero();
        final passenger = _passengerLocator.getPassengerById(passengerId);
        await passenger.walkToPoint(_taxi.position);
        _passengerLocator.disablePassengersPickUp();
        _gameState.startDeliver(
          passengerId: passengerId,
          destinationPoint: passenger.model.destinationPoint,
          maxDeliveryTime: passenger.model.maxDeliveryTime,
        );
        break;
      case DeliveringPassenger(
          :final passengerId,
          :final destinationPoint,
        ):
        game.world.controlsDisabled = false;
        _destinationArea = DestinationCircle(point: destinationPoint);
        game.world.add(_destinationArea!);
        final passenger = _passengerLocator.getPassengerById(passengerId);
        final taxiPassengerJointDef = DistanceJointDef()
          ..initialize(
            _taxi.body,
            passenger.body,
            _taxi.body.worldCenter,
            passenger.body.worldCenter,
          )
          ..length = 0;
        _taxiPassengerJoint = DistanceJoint(taxiPassengerJointDef);
        game.world.createJoint(_taxiPassengerJoint!);
        _deliveryArrow.position = Vector2(0, -5);
        _taxi.add(_deliveryArrow);
        break;
      case DisembarkingPassengerOnSuccessDelivery(
              :final passengerId,
              :final destinationPoint,
            ) ||
            DisembarkingPassengerOnFailedDelivery(
              :final passengerId,
              :final destinationPoint,
            ):
        game.world.controlsDisabled = true;
        _taxi.remove(_deliveryArrow);
        _taxi.currentDragDelta = Vector2.zero();
        if (_destinationArea case Component destinationArea) {
          game.world.remove(destinationArea);
        }
        if (_taxiPassengerJoint case Joint taxiPassengerJoint) {
          game.world.destroyJoint(taxiPassengerJoint);
        }
        final passenger = _passengerLocator.getPassengerById(passengerId);
        if (taxiState is DisembarkingPassengerOnSuccessDelivery) {
          await passenger.walkToPoint(destinationPoint);
        } else {
          passenger.walkToPoint(destinationPoint);
          await Future.delayed(const Duration(seconds: 5));
        }
        _passengerLocator.deletePassenger(passengerId);
        _gameState.disembarkingEnded();
        break;
    }
  }
}
