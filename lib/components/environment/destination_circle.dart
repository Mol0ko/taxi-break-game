import 'dart:ui';

import 'package:flame/components.dart';
import 'package:taxi_break_game/game_state/game_settings.dart';

class DestinationCircle extends CircleComponent {
  static const Color _startAnimationColor = Color.fromARGB(110, 255, 50, 204);
  static const Color _endAnimationColor = Color.fromARGB(109, 126, 3, 95);
  static const double _animationDuration = 0.7;

  double _lifeSeconds = 0.0;

  DestinationCircle({required Vector2 point, super.anchor = Anchor.center})
      : super(
          radius: GameSettings.startPickingUpRadius,
          paint: Paint()..color = _startAnimationColor,
          position: point,
        );

  @override
  void update(double dt) {
    _lifeSeconds += dt;

    final lifeSecondsMod = _lifeSeconds % (2 * _animationDuration);
    final lerpTimeline = lifeSecondsMod < _animationDuration
        ? lifeSecondsMod / _animationDuration
        : 2 * _animationDuration - lifeSecondsMod;
    paint.color =
        Color.lerp(_startAnimationColor, _endAnimationColor, lerpTimeline) ?? _startAnimationColor;
    super.update(dt);
  }
}
