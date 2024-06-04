import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/painting.dart';
import 'package:taxi_break_game/components/passengers/man_1_sprite.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class PassengerBody extends BodyComponent {
  // SETTINGS
  final double _pickUpAreaRadius = 52 / gameZoom;
  final Vector2 _passengerSize = Vector2.all(14) / gameZoom;
  final double _frictionFactor = 1;
  // END SETTINGS

  @override
  Future<void> onLoad() async {
    paint.color = const Color.fromARGB(0, 0, 0, 0);
    final passengerSprite = Man1Sprite(size: _passengerSize);
    final pickUpAreaPaint = Paint()..color = const Color.fromARGB(60, 17, 203, 26);
    final pickUpArea = CircleComponent(
      radius: _pickUpAreaRadius,
      paint: pickUpAreaPaint,
      anchor: Anchor.center,
    );
    await addAll([pickUpArea, passengerSprite]);
    await super.onLoad();
  }

  @override
  Body createBody() {
    // TODO: add actual start position of passenger
    final position = Vector2(130, 81);
    final def = BodyDef(position: position, type: BodyType.dynamic);
    final body = world.createBody(def)..userData = this;

    final shape = PolygonShape()..setAsBoxXY(_passengerSize.x / 2, _passengerSize.y / 2);
    final fixtureDef = FixtureDef(shape)
      ..density = 50
      ..restitution = 0.1;

    body.createFixture(fixtureDef);
    return body;
  }

  @override
  void update(double dt) {
    body.angularVelocity = 0;
    if (body.linearVelocity.length > 0.1) {
      body.linearVelocity -= body.linearVelocity * _frictionFactor * dt;
    } else {
      body.linearVelocity = Vector2.zero();
    }
    super.update(dt);
  }
}
