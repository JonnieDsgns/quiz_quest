import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class CharacterSelector extends StatelessWidget {
  CharacterSelector({super.key});
  static const routeName = '/character_selector';

  final List<String> characters = [  // Liste von vorgefertigten Charakteren (für alle Maps gleich). Notwendig, um FileLocation dynamisch machen zu können
    'character_1',
    'character_2',
    'character_3',
    'character_4',
    'character_5',
    'character_6',
  ];
  
  final TextEditingController nameController = TextEditingController();

  Future<void> savePlayerData(String name, String character) async {
    final box = await Hive.openBox('playerDataBox');
    await box.put('name', name);
    await box.put('character', character);
    print('Player data saved: Name: $name, Character: $character');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wähle deinen Charakter'),
      ),
      body: Column(
        children: [
          Padding( // FormField, um den Namen des Spielers einzutragen, wird in "playerData.txt" gespeichert
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: 600,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
          ),
          Expanded( // GridView für die Charakterauswahl
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () async {
                      String name = nameController.text;
                      String character = characters[index];
                      await savePlayerData(name, character);
                    },
                    child: Column(children: [
                      Center(
                        child: Image.asset('assets/images/player/${characters[index]}/character.png', // dynamische URL, um nicht jede Location der Datei hardcoden zu müssen
                          height: 128,
                          width: 64,
                          fit: BoxFit.contain,),
                      ),
                    ],) 
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}