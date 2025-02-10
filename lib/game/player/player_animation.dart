import 'package:bonfire/bonfire.dart';

// Klasse zur Festlegung der Animation für Character. String character ist notwendig, um den es dem Spieler zu ermöglichen, zu Beginn des Spiels einen Charakter auszuwählen.

class PlayerAnimation {
  static SimpleDirectionAnimation playerAnimations(String character) =>
    SimpleDirectionAnimation(
      idleRight: SpriteAnimation.load(
        'player/$character/${character}_idleRight.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 64),
        ),
      ),
      idleLeft: SpriteAnimation.load(
        'player/$character/${character}_idleLeft.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 64),
        ),
      ),
      idleUp: SpriteAnimation.load(
        'player/$character/${character}_idleUp.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 64),
        ),
      ),
      idleDown: SpriteAnimation.load(
        'player/$character/${character}_idleDown.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 64),
        ),
      ),
      runRight: SpriteAnimation.load(
        'player/$character/${character}_runRight.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 64),
        ),
      ),
      runLeft: SpriteAnimation.load(
        'player/$character/${character}_runLeft.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 64),
        ),
      ),
      runUp: SpriteAnimation.load(
        'player/$character/${character}_runUp.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 64),
        ),
      ),
      runDown: SpriteAnimation.load(
        'player/$character/${character}_runDown.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 64),
        ),
      ),
    );
}
  