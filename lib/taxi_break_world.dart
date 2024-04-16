import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:taxi_break_game/components/brick_surface.dart';
import 'package:taxi_break_game/components/taxi_sprite.dart';

class TaxiBreakWorld extends World with DragCallbacks {
  late final TaxiSprite _taxiSprite;

  @override
  Future<void> onLoad() async {
    _taxiSprite = TaxiSprite();
    final bricksSurface = BrickSurface();
    await addAll([bricksSurface, _taxiSprite]);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    _taxiSprite.position += event.canvasDelta;
    super.onDragUpdate(event);
  }
}
