import 'package:dino/my_dino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // dino variables
  static double dinoX = 0.0;
  static double dinoY = 0.0;
  double dinoWidth = 0.1;
  double dinoHeight = 0.1;

  // game settings
  bool gameHasStarted = false;

  void startGame(){

  }

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
