import 'package:flame/components.dart';

class TaxiSprite extends SpriteComponent {
  TaxiSprite({required super.size});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('cars/Car_Lancia_Delta_Integrale_Yellow_86x145.png');
    anchor = Anchor.center;
  }
}
