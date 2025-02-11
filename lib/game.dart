import 'package:hive/hive.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:quiz_quest/game/map/maps.dart';
import 'package:quiz_quest/game/player/player.dart';
import 'package:quiz_quest/interface/ui_elements_quiz.dart';
import 'package:quiz_quest/interface/score_controller.dart';

class Game extends StatefulWidget {
  const Game({super.key, required this.mapExteriorFile, required this.character});
  final String mapExteriorFile;  // Übertragen der Location der mapFile in den Assets von "character_selector.dart"
  final String character;  // Übertragen der Charakterwahl aus "character_selector.dart"

  @override 
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  bool isMenuVisible = false;  // Pausenmenü soll zuerst nicht sichtbar sein
  ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);  // Notifier für Score

  @override
  void initState() {
    super.initState();
  }

  void resetGameStats() {
    final box = Hive.box('quizDataBox');
    box.clear();
    toggleMenu();
    ScoreController().resetScore();
  }

  void toggleMenu() { // Funktion zum Umschalten der Sichtbarkeit des Pausenmenüs
    setState(() {
      isMenuVisible = !isMenuVisible;  
    });
  }

  void loadScore() async {
    final box = Hive.box('quizDataBox');
    scoreNotifier.value = box.get('score', defaultValue: 0);
    print('Score loaded: ${scoreNotifier.value}');
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [ 
            MapNavigator(
              maps: Maps.maps, 
              builder: (context, arguments, map) {
              MapArguments? mapArguments = arguments as MapArguments?;
              return BonfireWidget(  // GameWidget
                  player: Character(
                    (mapArguments?.playerPosition ?? Vector2(288, 2944)), // Legt die Startposition des Spielers fest
                    widget.character,
                    initDirection: mapArguments?.playerDirection ?? Direction.up,
                  ),
                  playerControllers: [
                    Joystick(
                      directional: JoystickDirectional(),
                    ),
                    Keyboard(
                      config: KeyboardConfig(
                        directionalKeys: [
                          KeyboardDirectionalKeys.arrows(),
                        ],
                      ),
                    ),
                  ],
                  map: map.map,
                  cameraConfig: CameraConfig(
                    zoom: getZoomFromMaxVisibleTile(context, 32, 20),
                    moveOnlyMapArea: true,
                  ),
                );
              },
            ),
            ScoreWidget(
              imgPath: 'assets/images/ui/score_${widget.character}.png',
            ),
            Positioned(  // UI Element für Pausenmenü_Button
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: toggleMenu,   // Funktion Sichtbarkeit Pausenmenü
                child: Image.asset(
                  'assets/images/ui/menu_button.png',
                  width: 50.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Visibility(  // Pausenmenü
              visible: isMenuVisible,
              child: Center(
                child: Container(
                  width: constraints.maxWidth,
                  color: Colors.black.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding( // Button, um zum Spiel zurückzukehren
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            toggleMenu();
                          }, 
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ui/ui_button_menu.png',
                                width: 256.0,
                                fit: BoxFit.contain,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text('Back',
                                style: TextStyle(
                                  fontFamily: 'Pixel',
                                  fontSize: 26,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      Padding( // Button, um das Spiel zu verlassen
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          }, 
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ui/ui_button_menu.png',
                                width: 256.0,
                                fit: BoxFit.contain,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text('Exit',
                                style: TextStyle(
                                  fontFamily: 'Pixel',
                                  fontSize: 26,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      Padding( // Button, um das Spiel zu verlassen
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              resetGameStats();
                          }, 
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ui/ui_button_menu.png',
                                width: 256.0,
                                fit: BoxFit.contain,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text('Reset',
                                style: TextStyle(
                                  fontFamily: 'Pixel',
                                  fontSize: 26,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}