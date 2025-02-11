import 'package:flutter/material.dart';
import 'package:quiz_quest/museum/json_loader.dart';
import 'package:quiz_quest/settings/settings_view.dart';
import 'package:quiz_quest/museum/museum_model.dart';
import 'package:quiz_quest/museum/museum_detail_view.dart';

class MuseumListView extends StatefulWidget {  // StatefulWidget, weil die Liste der Museen dynamisch ist und sich ändern kann
  const MuseumListView({super.key});
  static const routeName = '/';

  @override
  MuseumListViewState createState() => MuseumListViewState();
}

class MuseumListViewState extends State<MuseumListView> {
 late Future<List<MuseumItem>> futureItems; // Future, weil die Daten asynchron geladen werden. Die Daten sind die in museum_model.dart definierten MuseumItems.

 @override
 void initState() {
   super.initState();
   futureItems = loadMuseumItems(); // Funktion aus json_loader.dart, die die Daten aus den .json-Dateien lädt.
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Quest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName); // Navigation zu den Einstellungen
            },
          ),
        ],
      ),

      body: FutureBuilder<List<MuseumItem>>(
        future: futureItems,
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) { // If-Schleife, um bei Bedarf Ladebildschirm anzuzeigen, während die Daten geladen werden und einen Fehler anzuzeigen, falls die Daten nicht geladen werden können.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              restorationId: 'museumListView',
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0), // Match the rounded corners
                      onTap: () {
                      // Hierdurch wird zur Detailseite des jeweiligen Items navigiert, ohne bei Rückkehr den vorherigen Status zu verlieren.
                        Navigator.pushNamed(
                          context,
                          MuseumDetailView.routeName, arguments: item,
                        );
                      },
                      child: IntrinsicWidth( // IntrinsicWidth sorgt dafür, dass das Bild die komplette Breite des Card-Objekts füllt.
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.network(
                              item.imageUrl, height: 350, fit: BoxFit.cover, ),
                            ListTile(
                              minTileHeight: 70,
                              title: Text(item.museumName), // Der Titel des Items ist durch die beigefügte .json-Datei vorgegeben.
                              subtitle: Text(item.questTitle), // Der Untertitel des Items ist durch die beigefügte .json-Datei vorgegeben.
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                );
              },
            );
        }
      }),
    );
  }
}