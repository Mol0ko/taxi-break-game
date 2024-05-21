import 'package:flame/components.dart';

class Man1Sprite extends SpriteComponent {
  Man1Sprite({required super.size});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('people/man_1_idle.png');
    anchor = Anchor.center;
  }
}
