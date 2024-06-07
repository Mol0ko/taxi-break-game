import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_break_game/game_state/taxi_break_game_state.dart';
import 'package:taxi_break_game/game_state/taxi_state.dart';

class Hud extends PositionComponent with HasGameReference {
  final _gameState = TaxiBreakGameState.instance;

  late TextComponent _scoreTextComponent;
  late TextComponent _timerTextComponent;
  late final _deliveryTimer = Timer(
    0,
    onTick: _gameState.startDisembarkingOnFailedDelivery,
    autoStart: false,
  );
  var _timerStage = TimerStages.good;

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
        style: TextStyle(
          fontSize: 20,
          color: const Color.fromARGB(255, 255, 213, 0),
          fontWeight: FontWeight.bold,
          shadows: List.generate(
            5,
            (_) => const Shadow(
              blurRadius: 20.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
      anchor: Anchor.topRight,
      position: Vector2(game.size.x - 16, 56),
    );
    add(_scoreTextComponent);
    _timerTextComponent = TextComponent(
      text: '0:00',
      textRenderer: TimerStages.good.getTextRenderer(),
      anchor: Anchor.topCenter,
      position: Vector2(game.size.x / 2, 64),
    );

    _stateSubscription = _gameState.stateStream.listen(_gameStateListener);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _deliveryTimer.update(dt);
    if (_deliveryTimer.isRunning()) {
      _timerTextComponent.text = Duration(
        seconds: (_deliveryTimer.limit - _deliveryTimer.current).floor(),
      ).formatToTimerText();
      final timeProgressLeft = 1.0 - _deliveryTimer.progress;
      if (_timerStage == TimerStages.good &&
          timeProgressLeft <= TimerStages.normal.progressThreshold &&
          timeProgressLeft > TimerStages.bad.progressThreshold) {
        _timerStage = TimerStages.normal;
        _timerTextComponent.textRenderer = TimerStages.normal.getTextRenderer();
      } else if (_timerStage == TimerStages.normal &&
          timeProgressLeft <= TimerStages.bad.progressThreshold) {
        _timerStage = TimerStages.bad;
        _timerTextComponent.textRenderer = TimerStages.bad.getTextRenderer();
      }
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
      _deliveryTimer.stop();
      _deliveryTimer.limit = maxDeliveryTime.inSeconds.toDouble();
      _deliveryTimer.start();
    } else if (newState
        case DisembarkingPassengerOnSuccessDelivery() || DisembarkingPassengerOnFailedDelivery()) {
      remove(_timerTextComponent);
      _timerTextComponent.text = '0:00';
      _deliveryTimer.stop();
      _scoreTextComponent.text = 'Score: ${_gameState.passengersDelivered}';
    }
  }
}

extension TimerFormat on Duration {
  String formatToTimerText() => '${inMinutes.remainder(60)}'
      ':${(inSeconds.remainder(60).toString().padLeft(2, '0'))}';
}

enum TimerStages {
  good(
    color: Color.fromARGB(255, 148, 254, 140),
    progressThreshold: 1.0,
  ),
  normal(
    color: Color.fromARGB(255, 255, 235, 10),
    progressThreshold: 0.3,
  ),
  bad(
    color: Color.fromARGB(255, 253, 63, 15),
    progressThreshold: 0.12,
  );

  final Color color;
  final double progressThreshold;

  TextRenderer getTextRenderer() {
    return TextPaint(
      style: TextStyle(
        fontSize: 32,
        color: color,
        fontWeight: FontWeight.bold,
        shadows: List.generate(
          5,
          (_) => const Shadow(
            blurRadius: 20.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }

  const TimerStages({
    required this.color,
    required this.progressThreshold,
  });
}
