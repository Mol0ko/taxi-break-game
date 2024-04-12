import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:taxi_break_game/overlays/overlays.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Break',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(255, 221, 123, 1)),
        useMaterial3: true,
      ),
      home: GameWidget<TaxiBreakGame>.controlled(
        gameFactory: TaxiBreakGame.new,
        overlayBuilderMap: {
          OverlayNames.mainMenu: (_, game) => MainMenu(game: game),
          OverlayNames.gameOver: (_, game) => GameOver(game: game),
        },
        initialActiveOverlays: const [OverlayNames.mainMenu],
      ),
    );
  }
}
