import 'package:flutter/material.dart';

class MyDino extends StatelessWidget {
  MyDino({
    this.dinoX,
    this.dinoY,
    required this.dinoHeight,
    required this.dinoWidth,
  });

  final dinoX;
  final dinoY;
  final double dinoWidth;
  final double dinoHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        (2 * dinoX + dinoWidth) / (2 - dinoWidth),
        1,
      ),
      // x-axis, -1 of the left, 1 of the right
      // y-axis, -1 on the top, 1 of the bottom

      child: Container(
        // height: MediaQuery.of(context).size.height * 2 / 3 * dinoHeight,
        // width: MediaQuery.of(context).size.width * dinoWidth / 2,

        child: Image.asset(
          height: 50,
          width: 50,
          'images/dino.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
