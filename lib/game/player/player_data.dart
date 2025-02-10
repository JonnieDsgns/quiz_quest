import 'dart:io';


Future<bool> isPlayerDataAvailable() async {  // Funktion, um zu bestimmen, ob PlayerData.txt existiert
    const filePath = '/assets/data/playerData/playerData.txt';
    final file = File(filePath);

    if (await file.exists()) {
      final contents = await file.readAsString();
      return contents.isNotEmpty;
    } else {
      return false;
    }
  }

Future<int> readPlayerPosition() async { // Funktion, um gespeicherte Spielerposition auszulesen
  try {
    const filePath = '/assets/data/playerData/playerData.txt';
    final file = File(filePath);

    // Read the file
    final contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}