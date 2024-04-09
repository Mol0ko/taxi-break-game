import 'dart:developer';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

class TaxiBreakGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  TaxiBreakGame();

  void reset() {
    log('reset game');
  }
}
