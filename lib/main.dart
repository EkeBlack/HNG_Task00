import 'package:flutter/material.dart';
import 'package:hng_task00/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}
final themeNotifier = ValueNotifier(ThemeMode.system);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Utility App',
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: currentMode,
          home: const UtilityDashboardScreen(),
        );
      },
    );
  }
}


