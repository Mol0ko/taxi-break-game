import 'dart:async';

import 'package:flame/components.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_model.dart';
import 'package:taxi_break_game/components/passengers/passenger.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_type.dart';

class PassengerLocator extends Component {
  final List<PassengerBody> _passengers = [];
  Iterable<PassengerBody> get passengers => List.unmodifiable(_passengers);

  @override
  FutureOr<void> onLoad() async {
    final spawnPoint = Vector2(130, 81);
    final destinationPoint = Vector2(129.7, 183);
    const maxDeliveryTime = Duration(seconds: 30);
    // TODO: populate more passengers
    final passenger1Model = PassengerModel(
      type: PassengerType.man3,
      spawnPoint: spawnPoint,
      destinationPoint: destinationPoint,
      maxDeliveryTime: maxDeliveryTime,
    );
    final passenger1 = PassengerBody(model: passenger1Model);
    _passengers.add(passenger1);
    await add(passenger1);
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
