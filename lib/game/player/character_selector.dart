import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class CharacterSelector extends StatefulWidget {
  CharacterSelector({super.key});
  static const routeName = '/character_selector';

  final List<String> characters = [
    'character_1',
    'character_2',
    'character_3',
    'character_4',
    'character_5',
    'character_6',
  ];

  @override
  _CharacterSelectorState createState() => _CharacterSelectorState();
}

class _CharacterSelectorState extends State<CharacterSelector> {
  String? selectedCharacter;

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  Future<void> _loadPlayerData() async {
    final box = await Hive.openBox('playerDataBox');
    final character = box.get('character');
    setState(() {
      selectedCharacter = character;
    });
  }

  Future<void> savePlayerData(String character) async {
    final box = await Hive.openBox('playerDataBox');
    await box.put('character', character);
    print('Player data saved: Character: $character');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wähle deinen Charakter'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: widget.characters.length,
              itemBuilder: (context, index) {
                final character = widget.characters[index];
                final isSelected = selectedCharacter == character;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: isSelected ? Colors.amber : Colors.transparent,
                      width: 3.0,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () async {
                      setState(() {
                        selectedCharacter = character;
                      });
                      await savePlayerData(character);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/ui/preview_$character.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}