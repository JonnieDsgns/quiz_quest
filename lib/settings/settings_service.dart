import 'package:flutter/material.dart';

// Zuständig für das Speichern und Laden von Einstellungen
class SettingsService {
  Future<ThemeMode> themeMode() async => ThemeMode.system; // Lädt Theme-Modus des Systems als Standardvariante
  Future<void> updateThemeMode(ThemeMode themeMode) async {} 
}