import 'package:flutter/material.dart';

class MyBarriers extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final barrierY;

  MyBarriers({
    this.barrierHeight,
    this.barrierWidth,
    this.barrierX,
    this.barrierY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        ((2 * barrierX + barrierWidth) / (2 - barrierWidth)),
        1,
      ),
      child: Image.asset(
        'images/cactus1.png',
        width: MediaQuery.of(context).size.width * (barrierWidth / 2),
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
