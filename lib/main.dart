import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_quest/museum/museum_model.dart';
import 'package:quiz_quest/game/player/character_selector.dart';
import 'package:quiz_quest/settings/settings_controller.dart';
import 'package:quiz_quest/settings/settings_service.dart';
import 'package:quiz_quest/settings/settings_view.dart';
import 'package:quiz_quest/museum/museum_list_view.dart';
import 'package:quiz_quest/museum/museum_detail_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('quizDataBox');
  await Hive.openBox('playerDataBox');
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(MainApp(settingsController: settingsController));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          title: 'Quiz Quest',
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (BuildContext context) => 'Quiz Quest',
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case MuseumDetailView.routeName:
                    final item = routeSettings.arguments as MuseumItem;
                    return MuseumDetailView(item: item);
                  case CharacterSelector.routeName:
                    return CharacterSelector();
                  case MuseumListView.routeName:
                  default:
                    return const MuseumListView();
                }
              },
            );
          },
        );
      },
    );
  }
}