import 'dart:async';

import 'package:flame/components.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_model.dart';
import 'package:taxi_break_game/components/passengers/passenger.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_type.dart';

class PassengerLocator extends Component {
  final List<PassengerBody> _passengersById = [];
  Iterable<PassengerBody> get passengers => List.unmodifiable(_passengersById);

  @override
  FutureOr<void> onLoad() async {
    final spawnPoint = Vector2(130, 81);
    final destinationPoint = Vector2(130, 400);
    const maxDeliveryTime = Duration(seconds: 30);
    // TODO: populate more passengers
    final passenger1Model = PassengerModel(
      type: PassengerType.man3,
      spawnPoint: spawnPoint,
      destinationPoint: destinationPoint,
      maxDeliveryTime: maxDeliveryTime,
    );
    final passenger1 = PassengerBody(model: passenger1Model);
    _passengersById.add(passenger1);
    await add(passenger1);
    return super.onLoad();
  }
}
