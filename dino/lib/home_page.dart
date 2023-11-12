import 'dart:async';
import 'package:dino/barriers.dart';
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
  double initialPosition = dinoY;
  double dinoWidth = 0.1;
  double dinoHeight = 0.1;

  // barrier variables (out of 2)
  double barrierX = 1;
  double barrierY = 0;
  double barrierWidth = 0.1;
  double barrierHeight = 0.1;

  // jump variables
  double time = 0;
  double height = 0;
  double gravity = 9.8; // 9.8m/s^2
  double velocity = 2; // how strong the jump is

  // game settings
  bool gameHasStarted = false;
  bool midJump = false;
  bool gameOver = false;
  int score = 0;
  int highScore = 0;
  bool dinoPassedBarrier = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(
      Duration(milliseconds: 10),
      // 10 milisecond is the moving time of the barriers
      (timer) {
        height = (gravity * time * time) + (velocity * time);

        setState(() {
          dinoY = initialPosition - height;
        });

        // Update barrier positions
        for (int i = 0; i < barrierX; i++) {
          // Subtract a small value to move the barriers to the left
          barrierX -= 0.01; // Adjust the value as needed
        }

        if (dinoIsDead()) {
          timer.cancel();
          gameHasStarted = false;
          _showDialog();
        }

        // loop baarrier to keeep the app going
        loopBarriers();

        // keep the time going
        time += 0.01;
      },
    );
  }

  bool dinoIsDead() {
    // check if the dino hits the top of the screen
    if (dinoY > 1) {
      return true;
    }

    // hits barriers
    for (int i = 0; i < barrierX; i++) {
      if (barrierX <= dinoWidth &&
          barrierX + barrierWidth >= -dinoWidth &&
          (dinoY <= -1 + barrierHeight ||
              dinoY + dinoHeight >= 1 - barrierHeight)) {
        return true;
      }
    }

    return false;
  }

  void loopBarriers() {
    setState(() {
      if (barrierX <= -1.2) {
        barrierX = 1.2;
        dinoPassedBarrier = false;
      }
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPosition = dinoY;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      dinoX = 0;
      time = 0;
      initialPosition = dinoY;
      gameHasStarted = false;
      barrierX = 1;
      barrierY = 0;
    });
  }

  void _showDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text(
              'G A M E  O V E R',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(7),
                  color: Colors.white,
                  child: Text(
                    'P L A Y  A G A I N',
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void updateScore() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
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
                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                          gameHasStarted ? '' : 'TAP TO PLAY',
                          style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 30,
                          ),
                        ),
                      ),
                      MyDino(
                        dinoX: dinoX,
                        dinoY: dinoY,
                        dinoHeight: dinoHeight,
                        dinoWidth: dinoWidth,
                      ),
                      MyBarriers(
                        barrierX: barrierX,
                        barrierY: barrierY,
                        barrierHeight: barrierHeight,
                        barrierWidth: barrierWidth,
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
