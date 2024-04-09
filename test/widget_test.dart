import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_break_game/overlays/overlays.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GameWidget<TaxiBreakGame>.controlled(
      gameFactory: TaxiBreakGame.new,
      overlayBuilderMap: {
        OverlayNames.mainMenu: (_, game) => MainMenu(game: game),
        OverlayNames.gameOver: (_, game) => GameOver(game: game),
      },
      initialActiveOverlays: const [OverlayNames.mainMenu],
    ));
  });
}
