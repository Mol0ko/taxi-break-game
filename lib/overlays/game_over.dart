import 'package:flutter/material.dart';
import 'package:taxi_break_game/overlays/overlay_names.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class GameOver extends StatelessWidget {
  final TaxiBreakGame _game;

  const GameOver({required TaxiBreakGame game, super.key}) : _game = game;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textScheme = Theme.of(context).textTheme;

    return Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style: textScheme.headlineMedium,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {
                    _game.reset();
                    _game.overlays.remove(OverlayNames.gameOver);
                  },
                  child: Text(
                    'Play Again',
                    style: textScheme.headlineMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
