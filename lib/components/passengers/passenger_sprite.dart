import 'package:flame/components.dart';
import 'package:taxi_break_game/components/passengers/model/passenger_type.dart';

class PassengerSprite extends SpriteAnimationComponent with HasGameRef {
  final PassengerType type;

  PassengerSprite({
    required super.size,
    required this.type,
  });

  @override
  Future<void> onLoad() async {
    runIdleAnimation();
    anchor = Anchor.center;
  }

  Future<void> runIdleAnimation() async {
    animation = SpriteAnimation.fromFrameData(
      await gameRef.images.load(type.idleSpriteSource),
      SpriteAnimationData.sequenced(
        amount: 2,
        textureSize: Vector2.all(16),
        stepTime: 0.35,
      ),
    );
  }

  Future<void> runWalkAnimation() async {
    animation = SpriteAnimation.fromFrameData(
      await gameRef.images.load(type.walkSpriteSource),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.2,
      ),
    );
  }
}
