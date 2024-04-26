import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

class WallBody extends BodyComponent<TaxiBreakGame> {
  final Size size;
  final Vector2 startPosition;

  WallBody({required this.startPosition, required this.size});

  @override
  Future<void> onLoad() async {
    paint.color =  const Color.fromARGB(0, 0, 0, 0);
    super.onLoad();
  }

  @override
  Body createBody() {
    final def = BodyDef(position: startPosition, type: BodyType.static);
    final body = world.createBody(def)..userData = this;

    final shape = PolygonShape()..setAsBoxXY(size.width / 2, size.height / 2);
    final fixtureDef = FixtureDef(shape)..restitution = 0.1;

    body.createFixture(fixtureDef);

    return body;
  }
}
