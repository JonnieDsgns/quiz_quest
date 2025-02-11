import 'package:flutter/material.dart';
import 'package:quiz_quest/game.dart';
import 'package:hive/hive.dart';
import 'package:quiz_quest/museum/museum_model.dart';
import 'package:quiz_quest/interface/ui_elements.dart';
import 'package:quiz_quest/game/player/character_selector.dart';

class MuseumDetailView extends StatelessWidget {
  const MuseumDetailView({super.key, required this.item});
  static const routeName = '/museum_detail';
  final MuseumItem item;
  
    Future<String?> get character async {
    final box = await Hive.openBox('playerDataBox');
    return box.get('character');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.museumName), 
        actions: [
          IconButton(
            icon: const Icon(Icons.person), 
            onPressed: () {
              Navigator.restorablePushNamed(context, CharacterSelector.routeName);
            },
          ),
        ], // Titel basiert auf Museumsnamen, wird aus JSON Datei ausgelesen (json_loader)
      ),
      body: Column(
        children: [
          ImageSection( // BildURL wird aus JSON ausgelesen, Widget in ui_elements.dart definiert
            imageUrl: item.imageUrl 
          ),
          TitleSection( // Name und Titel werden aus JSON ausgelesen, Widget in ui_elements.dart definiert
            title: item.museumName,
            subtitle: item.questTitle,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: InfoSection(
                description: item.description, 
                museumName: item.museumName, 
                city: item.city, 
                address: item.address, 
                webURL: item.webURL, 
                phone: item.phone, 
                mail: item.mail,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton( // Button, um das Spiel zu starten
        onPressed: () async {
          final character = await this.character ?? 'character_1';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Game(mapExteriorFile: item.mapExterior, character: character),
            ),
          );
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }  
}