import 'dart:async';

import 'package:flame/components.dart';
import 'package:taxi_break_game/components/brick_sprite.dart';

class BrickSurface extends PositionComponent {
  @override
  FutureOr<void> onLoad() async {
    size = Vector2.all(10 * BrickSprite.brickSize);
    final bricks = List.generate(
      100,
      (index) => BrickSprite(
        position:
            Vector2((index % 10) * BrickSprite.brickSize, (index / 10).floor() * BrickSprite.brickSize),
      ),
    );
    await addAll(bricks);
    anchor = Anchor.center;
  }
}
