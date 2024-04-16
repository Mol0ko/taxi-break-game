import 'package:flame/components.dart';

class BrickSprite extends SpriteComponent {
  static const double brickSize = 128;

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
