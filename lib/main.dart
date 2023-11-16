import 'package:flutter/material.dart';
import 'package:hagman/game_screen.dart';
import 'package:hagman/start.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StartScreen(),
    );
  }
}
