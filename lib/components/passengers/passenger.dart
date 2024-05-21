import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';
import 'package:taxi_break_game/components/passengers/man_1_sprite.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class PassengerBody extends PositionComponent {
  // SETTINGS
  final double _pickUpAreaRadius = 48 / gameZoom;
  // END SETTINGS

  @override
  Future<void> onLoad() async {
    size = Vector2(43, 72) / gameZoom;
    final passengerSprite = Man1Sprite(size: Vector2.all(14) / gameZoom);

    final pickUpAreaPaint = Paint()..color = const Color.fromARGB(60, 17, 203, 26);
    final pickUpArea = CircleComponent(
      radius: _pickUpAreaRadius,
      paint: pickUpAreaPaint,
      anchor: Anchor.center,
    );

    await addAll([pickUpArea, passengerSprite]);
    position = Vector2(130, 81);
    await super.onLoad();
  }
}
