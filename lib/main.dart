import 'package:flutter/material.dart';
import 'package:taxi_break_game/screens/main_scene_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Break',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(255, 221, 123, 1)),
        useMaterial3: true,
      ),
      home: const MainSceneScreen(),
    );
  }
}
