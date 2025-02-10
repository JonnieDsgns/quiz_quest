import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quiz_quest/museum/museum_model.dart';

Future<List<MuseumItem>> loadMuseumItems() async {
  // Load the AssetManifest.json file
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  // Filter the JSON files in the assets/data directory
  final jsonFiles = manifestMap.keys
      .where((String key) => key.startsWith('assets/data/museumData') && key.endsWith('.json'))
      .toList();

  List<MuseumItem> items = [];
  for (String file in jsonFiles) {
    final String response = await rootBundle.loadString(file);
    if (response.isEmpty) {
      print('Warning: The file $file is empty.');
      continue;
    }
    try {
      final List<dynamic> data = json.decode(response);
      items.addAll(data.map((item) => MuseumItem.fromJson(item)).toList());
    } catch (e) {
      print('Error decoding JSON from file $file: $e');
    }
  }

  return items;
}

