import 'dart:async';
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/painting.dart';
import 'package:taxi_break_game/components/passengers/passenger_sprite.dart';
import 'package:taxi_break_game/components/passengers/passenger_locator.dart';
import 'package:taxi_break_game/components/passengers/passenger_type.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class PassengerBody extends BodyComponent {
  // SETTINGS
  final _pickUpAreaRadius = PassengerLocator.startPickingUpRadius;
  static const _passengerSpriteSize = Size(16, 16);
  final _passengerSize = _passengerSpriteSize / gameZoom;
  // END SETTINGS

  final PassengerType type;
  var _state = PassengerState.idle;
  late final PassengerSprite _passengerSprite;
  Vector2? movementTarget;
  Completer<void>? _movementCompleter;

  PassengerBody({required this.type});

  @override
  Future<void> onLoad() async {
    paint.color = const Color.fromARGB(0, 0, 0, 0);
    _passengerSprite = PassengerSprite(
      size: _passengerSize.toVector2(),
      type: type,
    );
    final pickUpAreaPaint = Paint()..color = const Color.fromARGB(60, 17, 203, 26);
    final pickUpArea = CircleComponent(
      radius: _pickUpAreaRadius,
      paint: pickUpAreaPaint,
      anchor: Anchor.center,
    );
    await addAll([pickUpArea, _passengerSprite]);
    await super.onLoad();
  }

  @override
  Body createBody() {
    // TODO: add actual start position of passenger
    final position = Vector2(130, 81);
    final def = BodyDef(position: position, type: BodyType.dynamic);
    final body = world.createBody(def)..userData = this;
    return body;
  }

  @override
  void update(double dt) {
    if (_state == PassengerState.moving) {
      _updateMoveToTaxi(dt);
    }
    super.update(dt);
  }

  Future<void> moveToTaxi({required Vector2 targetPosition}) async {
    _passengerSprite.runWalkAnimation();
    movementTarget = targetPosition;
    _movementCompleter = Completer<void>();
    _state = PassengerState.moving;
    await _movementCompleter!.future;
  }

  void _updateMoveToTaxi(double dt) {
    if (movementTarget == null || _movementCompleter == null) {
      log('Movement target or completer is null');
    }
    final distanceToTarget = movementTarget!.distanceTo(body.position);
    if (distanceToTarget < PassengerLocator.pickUpRadius) {
      _state = PassengerState.idle;
      movementTarget = null;
      _movementCompleter!.complete();
      _movementCompleter = null;
    } else {
      body.linearVelocity = (movementTarget! - body.position).normalized() * dt * 80;
    }
  }
}

enum PassengerState {
  idle,
  moving,
}
