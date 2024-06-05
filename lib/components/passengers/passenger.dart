import 'dart:async';
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/painting.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_model.dart';
import 'package:taxi_break_game/components/passengers/passenger_sprite.dart';
import 'package:taxi_break_game/game_state/game_settings.dart';

class PassengerBody extends BodyComponent {
  // SETTINGS
  static const _passengerSpriteSize = Size(16, 16);
  final _passengerSize = _passengerSpriteSize / GameSettings.gameZoom;
  // END SETTINGS

  final PassengerModel model;

  var _state = PassengerState.idle;
  late final PassengerSprite _passengerSprite;
  Vector2? _pickingUpTaxiTarget;
  Completer<void>? _movementCompleter;

  PassengerBody({required this.model});

  @override
  Future<void> onLoad() async {
    paint.color = const Color.fromARGB(0, 0, 0, 0);
    _passengerSprite = PassengerSprite(
      size: _passengerSize.toVector2(),
      type: model.type,
    );
    final pickUpAreaPaint = Paint()..color = const Color.fromARGB(60, 17, 203, 26);
    final pickUpArea = CircleComponent(
      radius: GameSettings.startPickingUpRadius,
      paint: pickUpAreaPaint,
      anchor: Anchor.center,
    );
    await addAll([pickUpArea, _passengerSprite]);
    await super.onLoad();
  }

  @override
  Body createBody() {
    final def = BodyDef(position: model.spawnPoint, type: BodyType.dynamic);
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
    _pickingUpTaxiTarget = targetPosition;
    _movementCompleter = Completer<void>();
    _state = PassengerState.moving;
    await _movementCompleter!.future;
  }

  void _updateMoveToTaxi(double dt) {
    if (_pickingUpTaxiTarget == null || _movementCompleter == null) {
      log('Movement target or completer is null');
    }
    final distanceToTarget = _pickingUpTaxiTarget!.distanceTo(body.position);
    if (distanceToTarget < GameSettings.pickUpRadius) {
      _state = PassengerState.idle;
      _pickingUpTaxiTarget = null;
      _movementCompleter!.complete();
      _movementCompleter = null;
    } else {
      body.linearVelocity = (_pickingUpTaxiTarget! - body.position).normalized() * dt * 80;
    }
  }
}

enum PassengerState {
  idle,
  moving,
}
