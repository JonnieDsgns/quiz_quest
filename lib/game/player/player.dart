import 'package:bonfire/bonfire.dart';
import 'package:quiz_quest/game/player/player_animation.dart';

class Character extends SimplePlayer with BlockMovementCollision{  // Definiert den Spieler

    Character(Vector2 position, String character, {Direction initDirection = Direction.up})
      : super(
          initDirection: initDirection, // Setzt den Startwert für Direction auf "up"
          animation: PlayerAnimation.playerAnimations(character), // Animationen in "player_animation.dart" definiert
          size: Vector2(32,64),
          position: position, // Position wird in der "game.dart" festgelegt
          life: 200,
          speed: 32 * 10, // Bewegungsgeschwindigkeit des Spielers
        );
  
  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2(32, 64),
      ),
    );
    return super.onLoad();
  }
}
