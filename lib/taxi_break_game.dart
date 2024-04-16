import 'dart:developer';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:taxi_break_game/taxi_break_world.dart';

class TaxiBreakGame extends FlameGame<TaxiBreakWorld>
    with SingleGameInstance, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color.fromRGBO(255, 221, 123, 1);

  TaxiBreakGame({super.world});

  void reset() {
    log('reset game');
  }
}
