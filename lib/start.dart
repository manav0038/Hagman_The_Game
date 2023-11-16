// start_screen.dart

import 'package:flutter/material.dart';
import 'package:hagman/game_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Welcome to Hangman!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Image.asset(
                'assets/gallow.png',
                height: 200,
                width: 200,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                child: Icon(Icons.play_arrow),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
