import 'package:flame/components.dart';

class TaxiSprite extends SpriteComponent {
  TaxiSprite({required super.size});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('cars/taxi-1.png');
    anchor = Anchor.center;
  }
}
