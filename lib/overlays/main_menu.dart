import 'package:flutter/material.dart';
import 'package:taxi_break_game/overlays/overlays.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class MainMenu extends StatelessWidget {
  final TaxiBreakGame _game;

  const MainMenu({required TaxiBreakGame game, super.key}) : _game = game;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textScheme = Theme.of(context).textTheme;

    return Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 300,
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
                'Taxi Break',
                style: textScheme.headlineMedium,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: () => _game.overlays.remove(OverlayNames.mainMenu),
                  child: Text(
                    'Play',
                    style: textScheme.displayMedium,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '''Use WASD or Arrow Keys for movement.
Space bar to jump.
Collect as many stars as you can and avoid enemies!''',
                textAlign: TextAlign.center,
                style: textScheme.bodySmall,
              ),
            ],
          ),
      ),
    );
  }
}
