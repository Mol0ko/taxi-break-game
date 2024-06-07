import 'dart:async';
import 'dart:convert';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_model.dart';
import 'package:taxi_break_game/components/passengers/passenger.dart';

class PassengerLocator extends Component {
  final List<PassengerBody> _passengers = [];
  Iterable<PassengerBody> get passengers => List.unmodifiable(_passengers);

  @override
  FutureOr<void> onLoad() async {
    final passengersInput = await rootBundle.loadString('assets/configuration/passengers.json');
    final passengersArrayJson = jsonDecode(passengersInput);
    for (final passengerJson in passengersArrayJson) {
      final passengerModel = PassengerModel.fromMap(passengerJson);
      _passengers.add(PassengerBody(model: passengerModel));
    }
    await addAll(_passengers);
    return super.onLoad();
  }

  PassengerBody getPassengerById(int id) => passengers.firstWhere((p) => p.model.id == id);

  void enablePassengersPickUp() {
    for (final passenger in passengers) {
      passenger.enablePickUpArea();
    }
  }

  void disablePassengersPickUp() {
    for (final passenger in passengers) {
      passenger.disablePickUpArea();
    }
  }

  void deletePassenger(int passengerId) {
    final passenger = getPassengerById(passengerId);
    _passengers.remove(passenger);
    remove(passenger);
  }
}
