import 'package:bonfire/bonfire.dart';
import 'package:quiz_quest/game/map/maps.dart';

class MapSensor extends GameDecoration with Sensor<Player> {
  final String id;
  bool hasContact = false;
  final String targetMap;
  final Vector2 playerPosition;
  final Direction playerDirection;

  MapSensor(
    this.id, // Name des Objekts
    Vector2 position,
    Vector2 size,
    this.targetMap, // ist in maps.dart als Inhalt der CustomProperty ['nextMap'] definiert
    this.playerPosition, // ist in maps.dart als Inhalt der CustomProperty ['playerPosition'] definiert
    this.playerDirection,  // ist in maps.dart als Inhalt der CustomProperty ['playerDirection'] definiert
  ) : super(
          position: position,
          size: size,
        );

  @override
  void onContact(Player component) {
    if (!hasContact) {
      hasContact = true;
      print('Contact has been made with $id');
      print('Navigating to $targetMap with position $playerPosition and direction $playerDirection');
      MapNavigator.of(context).toNamed(
        targetMap,
        arguments: MapArguments(
          playerPosition,
          playerDirection,
        ),
      );
    }
    super.onContact(component);
  }
}
