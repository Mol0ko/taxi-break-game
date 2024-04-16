import 'dart:developer';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:taxi_break_game/taxi_break_world.dart';

const double gameZoom = 10;

class TaxiBreakGame extends Forge2DGame<TaxiBreakWorld>
    with SingleGameInstance, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color.fromRGBO(255, 221, 123, 1);

  TaxiBreakGame({super.world, super.camera}) : super(gravity: Vector2.zero(), zoom: gameZoom);

  void reset() {
    log('reset game');
  }
}
