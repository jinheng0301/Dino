import 'dart:async';
import 'package:dino/my_dino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // dino variables (out of 2)
  static double dinoX = 0.0;
  static double dinoY = 0.0;
  double dinoWidth = 0.1;
  double dinoHeight = 0.1;

  // barrier variables (out of 2)
  double barrierX = 1;
  double barrierY = 1;
  double barrierWidth = 0.1;
  double barrierHeight = 0.1;

  // jump variables
  double time = 0;
  double height = 0;
  double gravity = 9.8; // 9.8m/s^2
  double velocity = 5; // how strong the jump is

  // game settings
  bool gameHasStarted = false;
  bool midJump = false;
  bool gameOver = false;
  int score = 0;
  int highScore = 0;
  bool dinoPassedBarrier = false;

  void startGame() {
    setState(() {
      gameHasStarted = true;
    });

    Timer.periodic(
      Duration(
          milliseconds: 10), // 10 milisecond is the moving time of the barriers
      (timer) {
        setState(() {
          barrierX = -0.01;
        });

        if (detectCollision()) {
          gameOver = true;
          timer.cancel();
          setState(() {
            if (score > highScore) {
              highScore = score;
            }
          });
        }
      },
    );
  }

  void detectCollision() {}

  void loopBarriers() {}

  void updateScore() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[200],
                child: Center(
                  child: Stack(
                    children: [
                      MyDino(
                        dinoX: dinoX,
                        dinoY: dinoY,
                        dinoHeight: dinoHeight,
                        dinoWidth: dinoWidth,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
