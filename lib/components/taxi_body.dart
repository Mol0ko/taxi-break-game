import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:taxi_break_game/components/taxi_sprite.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class TaxiBody extends BodyComponent<TaxiBreakGame> {
  final CameraComponent _camera;

  final size = const Size(43, 72) / gameZoom;
  Vector2 currentDragDelta = Vector2.zero();
  bool isDragging = false;

  // SETTINGS
  final double _accelerationFactor = 50;
  final double _frictionFactor = 1.2;
  final double _driftFactor = 0.93;
  final double _turnFactor = 0.05;
  final double _minimumSpeedToTurn = 4;
  // END SETTINGS

  Vector2 get _forwardVelocity {
    final currentForwardNormal = body.worldVector(Vector2(0.0, -1.0));
    return currentForwardNormal * body.linearVelocity.dot(currentForwardNormal);
  }

  Vector2 get _rightVelocity {
    final currentRightNormal = body.worldVector(Vector2(1.0, 0.0));
    return currentRightNormal * body.linearVelocity.dot(currentRightNormal);
  }

  TaxiBody({required CameraComponent camera}) : _camera = camera;

  @override
  Future<void> onLoad() async {
    final taxiSprite = TaxiSprite(size: size.toVector2());
    await add(taxiSprite);
    await super.onLoad();
  }

  @override
  Body createBody() {
    final startPosition = Vector2(0, 30);
    final def = BodyDef(position: startPosition, type: BodyType.dynamic);
    final body = world.createBody(def)
      ..userData = this
      ..angularDamping = 3.0
      ..inverseInertia = 3.0;

    final shape = PolygonShape()..setAsBoxXY(size.width / 2, size.height / 2);
    final fixtureDef = FixtureDef(shape)
      ..density = 0.2
      ..restitution = 2.0;

    body.createFixture(fixtureDef);

    return body;
  }

  @override
  void update(double dt) {
    _updateDrive(dt);
    _killOrthogonalVelocity();
    _updateTurn(dt);
    _camera.viewfinder.position = position;
  }

  void _updateDrive(double dt) {
    final currentForwardNormal = body.worldVector(Vector2(0.0, -1.0));

    if (isDragging) {
      final dragDy = currentDragDelta.y;
      if (dragDy < 0) {
        body.applyForce(currentForwardNormal * _accelerationFactor);
      } else if (dragDy > 0) {
        body.applyForce(-currentForwardNormal * _accelerationFactor);
      }
    } else {
      body.angularVelocity = 0;
      if (body.linearVelocity.length > 0.1) {
        body.linearVelocity -= body.linearVelocity * _frictionFactor * dt;
      } else {
        body.linearVelocity = Vector2.zero();
      }
      return;
    }
  }

  void _updateTurn(double dt) {
    if (!isDragging || _forwardVelocity.length < _minimumSpeedToTurn) return;
    body.applyAngularImpulse(currentDragDelta.x * _turnFactor);
  }

  void _killOrthogonalVelocity() {
    body.linearVelocity = _forwardVelocity + _rightVelocity * _driftFactor;
  }
}
