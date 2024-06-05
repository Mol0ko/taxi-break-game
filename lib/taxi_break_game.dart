import 'dart:developer';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:taxi_break_game/game_state/game_settings.dart';
import 'package:taxi_break_game/taxi_break_world.dart';

class TaxiBreakGame extends Forge2DGame<TaxiBreakWorld> with SingleGameInstance {
  @override
  Color backgroundColor() => const Color.fromRGBO(255, 221, 123, 1);

  TaxiBreakGame({super.world, super.camera})
      : super(gravity: Vector2.zero(), zoom: GameSettings.gameZoom);

  void reset() {
    log('reset game');
  }
}
