import 'package:flutter/material.dart';
import 'package:mypuzzle/screenv4.dart';
import 'package:mypuzzle/screenv6.dart';


void main() {
  runApp(const MyPuzzle());
}


class MyPuzzle extends StatelessWidget {
  const MyPuzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screenv6(),
    );
  }
}
