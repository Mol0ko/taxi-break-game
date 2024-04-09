import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:taxi_break_game/overlays/overlays.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

void main() {
  runApp(
    GameWidget<TaxiBreakGame>.controlled(
      gameFactory: TaxiBreakGame.new,
      overlayBuilderMap: {
        OverlayNames.mainMenu: (_, game) => MainMenu(game: game),
        OverlayNames.gameOver: (_, game) => GameOver(game: game),
      },
      initialActiveOverlays: const [OverlayNames.mainMenu],
    ),
  );
}
