import 'package:flutter/material.dart';

class MainSceneScreen extends StatelessWidget {
  const MainSceneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: const Center(
        child: Text('TAXI BREAK'),
      ),
    );
  }
}
