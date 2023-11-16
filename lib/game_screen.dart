import 'package:flutter/material.dart';
import 'package:hagman/const/consts.dart';
import 'package:hagman/game/figure.dart';
import 'package:hagman/game/letters.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var characters = "abcdefghijklmnopqrstuvwxyz".toUpperCase();
  var word = "letters".toUpperCase();
  List<String> selectedChar = [];
  var tries = 0;

  void restartGame() {
    setState(() {
      selectedChar.clear();
      tries = 0;
    });
  }

  void showCongratulationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'You guessed the word!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tries used: $tries',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    restartGame();
                  },
                  child: Text('OK'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,
                    minimumSize: Size(120, 40),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showOopsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oops! Better luck next time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/6.png'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  restartGame();
                },
                child: Text('Restart'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black54,
                  minimumSize: Size(120, 40),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hangman: The Game"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      figure(GameUI.hang, tries >= 0),
                      figure(GameUI.head, tries >= 1),
                      figure(GameUI.body, tries >= 2),
                      figure(GameUI.leftArm, tries >= 3),
                      figure(GameUI.rightArm, tries >= 4),
                      figure(GameUI.leftLeg, tries >= 5),
                      figure(GameUI.rightLeg, tries >= 6),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: word
                          .split("")
                          .map((e) => hiddenletter(
                              e, !selectedChar.contains(e.toUpperCase())))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                crossAxisCount: 7,
                children: characters.split("").map((e) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    onPressed: selectedChar.contains(e.toUpperCase())
                        ? null
                        : () {
                            setState(() {
                              selectedChar.add(e.toUpperCase());
                              if (!word.split("").contains(e.toUpperCase())) {
                                tries++;
                                if (tries == 6) {
                                  showOopsDialog();
                                }
                              } else if (word.split("").every(
                                  (char) => selectedChar.contains(char))) {
                                showCongratulationDialog();
                              }
                            });
                          },
                    child: Text(
                      e,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
