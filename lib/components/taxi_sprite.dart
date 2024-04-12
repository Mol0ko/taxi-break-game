import 'package:flame/components.dart';

class TaxiSprite extends SpriteComponent {
  TaxiSprite() : super(size: Vector2.all(32));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('dash.png');
  }
}
