import 'dart:async';

import 'package:flame/components.dart';
import 'package:taxi_break_game/components/brick_sprite.dart';

class BrickSurface extends PositionComponent {
  @override
  FutureOr<void> onLoad() async {
    const bricksSideCount = 100;
    size = Vector2.all(bricksSideCount * BrickSprite.brickSize);
    final bricks = List.generate(
      bricksSideCount * bricksSideCount,
      (index) => BrickSprite(
        position: Vector2((index % bricksSideCount) * BrickSprite.brickSize,
            (index / bricksSideCount).floor() * BrickSprite.brickSize),
      ),
    );
    await addAll(bricks);
    anchor = Anchor.center;
  }
}
