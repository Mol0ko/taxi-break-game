import 'dart:async';

import 'package:flame/components.dart';
import 'package:taxi_break_game/components/environment/brick_sprite.dart';

class BrickSquareSurface extends PositionComponent {
  final int side;

  BrickSquareSurface({required this.side});

  @override
  FutureOr<void> onLoad() async {
    size = Vector2.all(side * BrickSprite.brickSize);
    final bricks = List.generate(
      side * side,
      (index) => BrickSprite(
        position: Vector2((index % side) * BrickSprite.brickSize,
            (index / side).floor() * BrickSprite.brickSize),
      ),
    );
    await addAll(bricks);
    anchor = Anchor.center;
  }
}
