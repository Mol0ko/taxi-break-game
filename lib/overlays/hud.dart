import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_break_game/game_state/taxi_break_game_state.dart';
import 'package:taxi_break_game/game_state/taxi_state.dart';

class Hud extends PositionComponent with HasGameReference {
  final _gameState = TaxiBreakGameState.instance;

  late TextComponent _scoreTextComponent;
  late TextComponent _timerTextComponent;

  StreamSubscription? _stateSubscription;

  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  @override
  FutureOr<void> onLoad() {
    _scoreTextComponent = TextComponent(
      text: 'Score: ${_gameState.passengersDelivered}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 255, 213, 0),
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 1.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
      ),
      anchor: Anchor.topRight,
      position: Vector2(game.size.x - 16, 56),
    );
    add(_scoreTextComponent);
    _timerTextComponent = TextComponent(
      text: '00:00:00',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromARGB(255, 255, 249, 217),
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 1.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
      ),
      anchor: Anchor.topCenter,
      position: Vector2(game.size.x / 2, 64),
    );

    _stateSubscription = _gameState.stateStream.listen(_gameStateListener);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (_gameState.state case DeliveringPassenger(:final maxDeliveryTime)) {
      _timerTextComponent.text = maxDeliveryTime.formatToTimerText();
    }
    super.update(dt);
  }

  @override
  void onRemove() {
    _stateSubscription?.cancel();
    super.onRemove();
  }

  void _gameStateListener(TaxiState newState) {
    if (newState case DeliveringPassenger(:final maxDeliveryTime)) {
      _timerTextComponent.text = maxDeliveryTime.formatToTimerText();
      add(_timerTextComponent);
    } else if (newState case DisembarkingPassenger()) {
      _timerTextComponent.text = '00:00:00';
      remove(_timerTextComponent);
    }
  }
}

extension TimerFormat on Duration {
  String formatToTimerText() => '$inHours'
      ':${inMinutes.remainder(60)}'
      ':${(inSeconds.remainder(60))}';
}
