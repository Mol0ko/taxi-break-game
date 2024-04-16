import 'package:flame/components.dart';

class TaxiSprite extends SpriteComponent {
  TaxiSprite() : super(size: Vector2(43, 72));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('cars/Car_Lancia_Delta_Integrale_Yellow_86x145.png');
    anchor = Anchor.center;
  }
}
