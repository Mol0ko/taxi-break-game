import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:taxi_break_game/game_state/game_settings.dart';

class DeliveryArrow extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    size = (const Size(16, 24) / GameSettings.gameZoom).toVector2();
    sprite = await Sprite.load('environment/delivery_arrow.png');
    anchor = Anchor.center;
  }
}
