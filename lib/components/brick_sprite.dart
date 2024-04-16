import 'package:flame/components.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class BrickSprite extends SpriteComponent {
  static const double brickSize = 128 / gameZoom;

  BrickSprite({required Vector2 position})
      : super(
          size: Vector2(brickSize, brickSize),
          position: position,
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('environment/Bricks_16-128x128.png');
  }
}
