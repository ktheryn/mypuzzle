import 'package:flutter/material.dart';
import 'package:mypuzzle/flutter_boy.dart';
import 'package:mypuzzle/screenv10.dart';
import 'package:mypuzzle/screenv7.dart';
import 'package:mypuzzle/screenv8.dart';
import 'package:mypuzzle/screenv9.dart';


void main() {
  runApp(const MyPuzzle());
}


class MyPuzzle extends StatelessWidget {
  const MyPuzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlutterBoy(),
    );
  }
}
