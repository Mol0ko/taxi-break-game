import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:taxi_break_game/components/taxi_sprite.dart';

class TaxiBreakGame extends FlameGame with SingleGameInstance, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color.fromRGBO(255, 221, 123, 1);

  TaxiBreakGame();

  @override
  FutureOr<void> onLoad() {
    world.add(TaxiSprite());
    return super.onLoad();
  }

  void reset() {
    log('reset game');
  }
}
