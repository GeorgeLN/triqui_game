import 'package:flutter/material.dart';
import 'package:triqui_game/screens/_screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Material App',
      initialRoute: 'home',

      routes: {
        'home': (context) => HomeScreen(),
      },

      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return const ErrorScreen();
          },
        );
      },
    );
  }
}