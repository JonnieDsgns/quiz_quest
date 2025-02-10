import 'package:bonfire/bonfire.dart';
import 'package:bonfire/map/tiled/builder/tiled_world_builder.dart';
import 'package:quiz_quest/game/map/map_sensor.dart';
import 'package:quiz_quest/game/map/quiz_sensor.dart';

class MultiScenarioAssets {
  static const String mapExterior = 'https://raw.githubusercontent.com/JonnieDsgns/data_quiz_quest/refs/heads/master/tiled/museum_a_map_exterior.json';
  static const String mapInterior1 = 'tiled/museum_a_map_nat.json';
  static const String mapInterior2 = 'tiled/museum_a_map_art.json';
  static const String mapInterior3 = 'tiled/museum_a_map_arch.json';
}

enum MapID { none, exterior, interior1, interior2, interior3 }

abstract class Maps {
  static get maps => {
        MapID.exterior.name: (context, args) {
          return MapItem(
            id: MapID.exterior.name,
            map: WorldMapByTiled(
              WorldMapReader.fromNetwork(Uri.parse(MultiScenarioAssets.mapExterior)),
              objectsBuilder: _objectBuilder,
            ),
          );
        },
        MapID.interior1.name: (context, args) => MapItem(
              id: MapID.interior1.name,
              map: WorldMapByTiled(
                WorldMapReader.fromAsset(MultiScenarioAssets.mapInterior1),
                objectsBuilder: _objectBuilder,
              ),
            ),
        MapID.interior2.name: (context, args) => MapItem(
              id: MapID.interior2.name,
              map: WorldMapByTiled(
                WorldMapReader.fromAsset(MultiScenarioAssets.mapInterior2),
                objectsBuilder: _objectBuilder,
              ),
            ),
         MapID.interior3.name: (context, args) => MapItem(
              id: MapID.interior3.name,
              map: WorldMapByTiled(
                WorldMapReader.fromAsset(MultiScenarioAssets.mapInterior3),
                objectsBuilder: _objectBuilder,
              ),
            ),
      };

  static Map<String, ObjectBuilder> get _objectBuilder => { // Getter, um die Objekte auf der Map zu erstellen
        'sensor': (p) {
          final parts = p.others['playerPosition'].toString().split(','); // p.others sind die Custom Properties. ['playerPosition'] zielt dabei auf die gleichnamige Custom Property innerhalb der Liste ab und konvertiert den Wert in einen String
          Vector2 playerPosition = Vector2( // final parts wird hier zu einem Vector2 zusammengesetzt, der dan die PlayerPosition für den Eintritt des Spielers in die Map stellt
            double.parse(parts[0]),
            double.parse(parts[1]),
          );
          return MapSensor(
            'sensor',
            p.position,
            p.size,
            p.others['nextMap'].toString(), // Ist der Wert für this.targetMap in map_sensor.dart. p.others sind die Custom Properties. ['nextMap'] zielt dabei auf die gleichnamige Custom Property innerhalb der Liste ab und konvertiert den Wert in einen String
            playerPosition,
            Direction.fromName(p.others['playerDirection'].toString()), // p.others sind die Custom Properties. ['playerDirection'] zielt dabei auf die gleichnamige Custom Property innerhalb der Liste ab und konvertiert den Wert in einen String. FromName wiederum konvertiert den String in ein DirecionObject
          );
        },
        'questionSensor': (p) {
          return QuizSensor(
            'questionSensor',
            p.position,
            p.size,
            p.others['questionFilePath'].toString(), // Ist der Wert für this.targetMap in map_sensor.dart. p.others sind die Custom Properties. ['nextMap'] zielt dabei auf die gleichnamige Custom Property innerhalb der Liste ab und konvertiert den Wert in einen String
            p.others['questionID'].toString(), // Ist der Wert für this.targetMap in map_sensor.dart. p.others sind die Custom Properties. ['nextMap'] zielt dabei auf die gleichnamige Custom Property innerhalb der Liste ab und konvertiert den Wert in einen String            Direction.fromName(p.others['playerDirection'].toString()), // p.others sind die Custom Properties. ['playerDirection'] zielt dabei auf die gleichnamige Custom Property innerhalb der Liste ab und konvertiert den Wert in einen String. FromName wiederum konvertiert den String in ein DirecionObject
          );
        },
      };
}

class MapArguments {
  final Vector2 playerPosition;
  final Direction playerDirection;

  MapArguments(this.playerPosition, this.playerDirection);
}
