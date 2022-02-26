//FINAL DRAFT
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:rive/rive.dart';

class FlutterBoy extends StatefulWidget {
  const FlutterBoy({Key? key}) : super(key: key);

  @override
  _FlutterBoyState createState() => _FlutterBoyState();
}

class _FlutterBoyState extends State<FlutterBoy> {
  List<int> puzzleGridListOriginal = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
  List<int> puzzleGridList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0, 15];

  bool isEmpty = true;
  bool isFlutterBoySwitchedOn = false;
  int currentPuzzleMoves = 0;
  bool isFinished = false;
  int currentScreen = 0;

  Map<int, int>  screenOptionSet = {//Currently selected option on current screen [screen:current option]
    0: 0,
    1: 0,
    2: 1,//1,2
    3: -1,//0to15
    4: 1,//1,2
    5: 0,
  };

  Map<int, List<int>> arrowKeyPuzzleMoveSet = {//LeftRightTopBottom
    0: [-1, 1,-1, 4],
    1: [ 0, 2,-1, 5],
    2: [ 1, 3,-1, 6],
    3: [ 2,-1,-1, 7],
    4: [-1, 5, 0, 8],
    5: [ 4, 6, 1, 9],
    6: [ 5, 7, 2,10],
    7: [ 6,-1, 3,11],
    8: [-1, 9, 4,12],
    9: [ 8,10, 5,13],
    10: [ 9,11, 6,14],
    11: [10,-1, 7,15],
    12: [-1,13, 8,-1],
    13: [12,14, 9,-1],
    14: [13,15,10,-1],
    15: [14,-1,11,-1],
  };

  Map<int, List<int>> puzzlePieceSlideLocationsSet = {
    0: [1, 4],
    1: [0, 2, 5],
    2: [6, 1, 3],
    3: [2, 7],
    4: [0, 5, 8],
    5: [1, 6, 4, 9],
    6: [2, 5, 7, 10],
    7: [3, 6, 11],
    8: [4, 9, 12],
    9: [5, 8, 10, 13],
    10: [6, 9, 11, 14],
    11: [7, 10, 15],
    12: [8, 13],
    13: [9, 12, 14],
    14: [10, 13, 15],
    15: [11, 14],
  };

  List<MaterialColor> flutterBoyLogoColorSet = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  TextStyle flutterBoyLogoTextStyle = const TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Cabin',
  );

  void flutterBoyKeyNote(int audioNumber, String playerMode) {
    AudioCache player = AudioCache(prefix: 'assets/');
    if(playerMode == 'play'){
      player.play('note$audioNumber.wav');
    }else{
      player.clear(Uri.parse('note$audioNumber.wav'));
    }
  }

  pressedFlutterBoyControlButton(pressedControlButton){
    if(pressedControlButton == "Left"){
      if(currentScreen == 2){
        setState(() {
          screenOptionSet[currentScreen]=1;
          flutterBoyKeyNote(3,'play');
        });
      }else if(currentScreen == 3){
        if(arrowKeyPuzzleMoveSet[puzzleGridList.indexOf(0)]![0] != -1){
          setState(() {
            screenOptionSet[currentScreen]=arrowKeyPuzzleMoveSet[puzzleGridList.indexOf(0)]![0];
          });
        }
      }else if(currentScreen == 4){
        setState(() {
          screenOptionSet[currentScreen]=1;
          flutterBoyKeyNote(3,'play');
        });
      }
    }else if(pressedControlButton == "Right"){
      if(currentScreen == 2){
        setState(() {
          screenOptionSet[currentScreen]=2;
          flutterBoyKeyNote(3,'play');
        });
      }else if(currentScreen == 3){
        if(arrowKeyPuzzleMoveSet[puzzleGridList.indexOf(0)]![1] != -1){
          setState(() {
            screenOptionSet[currentScreen]=arrowKeyPuzzleMoveSet[puzzleGridList.indexOf(0)]![1];
          });
        }
      }else if(currentScreen == 4){
        setState(() {
          screenOptionSet[currentScreen]=2;
          flutterBoyKeyNote(3,'play');
        });
      }
    }else if(pressedControlButton == "Up"){
      if(currentScreen == 3){
        if(arrowKeyPuzzleMoveSet[puzzleGridList.indexOf(0)]![2] != -1){
          setState(() {
            screenOptionSet[currentScreen]=arrowKeyPuzzleMoveSet[puzzleGridList.indexOf(0)]![2];
          });
        }
      }
    }else if(pressedControlButton == "Down"){
      if(currentScreen == 3){
        if(arrowKeyPuzzleMoveSet[puzzleGridList.indexOf(0)]![3] != -1){
          setState(() {
            screenOptionSet[currentScreen]=arrowKeyPuzzleMoveSet[puzzleGridList.indexOf(0)]![3];
          });
        }
      }
    }else if(pressedControlButton == "A"){
      if(currentScreen == 2){
        if(screenOptionSet[currentScreen] == 1){
          setState(() {
            //numbers.shuffle();//TODO:comment during testing
            currentPuzzleMoves = 0;
            currentScreen = 3;
            flutterBoyKeyNote(3,'play');
          });
          screenOptionSet[currentScreen]=puzzlePieceSlideLocationsSet[puzzleGridList.indexOf(0)]![0];
          flutterBoyKeyNote(11,'play');
        }else if(screenOptionSet[currentScreen] == 2){
          setState(() {
            currentScreen = 5;
            flutterBoyKeyNote(3,'play');
          });
        }
      }else if(currentScreen == 3){
        swapPuzzlePiece();
        if(listEquals(puzzleGridList,puzzleGridListOriginal)){//Compares original list with current puzzle
          Future.delayed(const Duration(milliseconds: 500),(){
            setState(() {
              currentScreen = 4;
            });
          });
          flutterBoyKeyNote(6,'play');
        }else{
          flutterBoyKeyNote(2,'play');
        }
      }else if(currentScreen == 4){
        if(screenOptionSet[currentScreen] == 1){
          setState(() {
            puzzleGridList.shuffle();
            currentScreen = 3;
            currentPuzzleMoves = 0;
            flutterBoyKeyNote(3,'play');
          });
          screenOptionSet[currentScreen]=puzzlePieceSlideLocationsSet[puzzleGridList.indexOf(0)]![0];
        }else if(screenOptionSet[currentScreen] == 2){
          setState(() {
            currentScreen = 2;
            flutterBoyKeyNote(3,'play');
          });
        }
      }
    }else if(pressedControlButton == "B"){
      if(currentScreen == 3){
        setState(() {
          currentScreen = 2;
          flutterBoyKeyNote(3,'play');
        });
      }else if(currentScreen == 5){
        setState(() {
          currentScreen = 2;
          flutterBoyKeyNote(3,'play');
        });
      }
    }else if(pressedControlButton == "Start"){
      if(currentScreen == 2){
        setState(() {
          currentScreen = 3;
        });
        screenOptionSet[currentScreen]=puzzlePieceSlideLocationsSet[puzzleGridList.indexOf(0)]![0];
      }
    }else if(pressedControlButton == "Select"){
      if(currentScreen == 2){
        setState(() {
          currentScreen = 5;
        });
      }
    }
  }

  puzzlePieceBorderColor(currentPuzzlePieceIndex){
    if(currentPuzzlePieceIndex == screenOptionSet[currentScreen]){
      return Colors.teal;
    }else{
      return Colors.transparent;
    }
  }

  swapPuzzlePiece(){
    int? currentSelectedPuzzlePieceIndex = screenOptionSet[currentScreen];
    int emptyPuzzlePieceLocationIndex,tempValue=0;

    for (int i = 0; i < puzzlePieceSlideLocationsSet[screenOptionSet[currentScreen]]!.length; i++) {
      emptyPuzzlePieceLocationIndex = puzzlePieceSlideLocationsSet[screenOptionSet[currentScreen]]![i];
      if (puzzleGridList[emptyPuzzlePieceLocationIndex] == 0 && currentSelectedPuzzlePieceIndex != null) {
        setState(() {
          puzzleGridList[emptyPuzzlePieceLocationIndex] = puzzleGridList[currentSelectedPuzzlePieceIndex];
          puzzleGridList[currentSelectedPuzzlePieceIndex] = 0;
          currentPuzzleMoves++;
          tempValue = emptyPuzzlePieceLocationIndex;
        });
      }
    }
    screenOptionSet[currentScreen] = tempValue;
  }

  getCurrentScreenContents() {
    if (currentScreen == 0) {
      return Container(
        color: const Color(0xFF9CA04C),
      );
    } else if (currentScreen == 1) {
      return Container(
        color: Colors.white,
        height: 350,
        child: Center(
          child: AnimatedTextKit(
            onFinished: () {
              setState(() {
                isFlutterBoySwitchedOn = true;
                currentScreen = 2;
              });
            },
            totalRepeatCount: 1,
            animatedTexts: [
              ColorizeAnimatedText(
                'FLUTTERBOY',
                textStyle: flutterBoyLogoTextStyle,
                colors: flutterBoyLogoColorSet,
                speed: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      );
    } else if (currentScreen == 2) {
      return Container(
          color: Colors.white,
          height: 350,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sliders Game',
                  style: TextStyle(fontFamily: 'VT323', fontSize: 45),
                ),
              ),
              const Expanded(
                child: Center(
                  child: RiveAnimation.asset(
                    'assets/6cubes.riv',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height:40,
                      width: 100,
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 3.0, color: screenOptionSet[currentScreen] == 1 ? Colors.teal : Colors.transparent,),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'VT323',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height:40,
                      width: 100,
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 3.0, color: screenOptionSet[currentScreen] == 2 ? Colors.teal : Colors.transparent,),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Controls',
                          style: TextStyle(fontFamily: 'VT323', fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    } else if (currentScreen == 3) {
      return Container(
        color: const Color(0xFF414143),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 270,
              width: 270,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 7.5, bottom: 0),//7.5
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: puzzleGridList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (puzzleGridList[index] != 0) {
                      return Container(
                        decoration: BoxDecoration(
                          //border: Border.all(width: 3.0, color: screenOption[screenValue] == numbers[index] ? Colors.teal : Colors.transparent,),
                          border: Border.all(width: 3.0, color: puzzlePieceBorderColor(index),),
                          borderRadius: const BorderRadius.all(Radius.circular(10,),),
                          image: DecorationImage(
                            image: AssetImage(
                                'images/dash_' + puzzleGridList[index].toString() + '.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Text(numbers[index].toString()),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 70,
                  height: 23,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0,color: Colors.teal),
                    borderRadius: const BorderRadius.all(Radius.circular(20,),),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Text(
                            "A",
                            style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 18,),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Center(
                        child: Text(
                          "MOVE",
                          style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20,),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Moves:" + currentPuzzleMoves.toString(),
                  style: const TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 25,),
                ),
                Container(
                  width: 70,
                  height: 23,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0,color: Colors.teal),
                    borderRadius: const BorderRadius.all(Radius.circular(20,),),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Text(
                            "B",
                            style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 18,),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Center(
                        child: Text(
                          "EXIT",
                          style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20,),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }else if (currentScreen == 4) {
      return Container(
        color: const Color(0xFF414143),
        child: Stack(
          children: [
            Center(
              child: Lottie.asset(
                'winner.json',
                width: 300.0,
                repeat: true,
                fit: BoxFit.fitWidth,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'You just got Lucky!',
                    style: TextStyle(letterSpacing: 0.5,color: Colors. white,fontFamily: 'VT323', fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height:40,
                        width: 100,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0, color: screenOptionSet[4] == 1 ? Colors.teal : Colors.transparent,),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Center(
                            child: Text(
                              'Retry',
                              style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height:40,
                        width: 100,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0, color: screenOptionSet[4] == 2 ? Colors.teal : Colors.transparent,),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Center(
                            child: Text(
                              'Home',
                              style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }else if (currentScreen == 5) {
      return Container(
        color: const Color(0xFF414143),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'GAME CONTROLS',
                style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Navigate: ',
                    style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.gamepad,color: Colors.white,),
                const SizedBox(
                  width: 82,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Move: ',
                    style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 18,
                  width: 18,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      "A",
                      style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 18,),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                'KEYBOARD LAYOUT',
                style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Left :',
                            style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.arrow_back_rounded,color: Colors.white,),
                        const SizedBox(
                          width: 82,
                        ),
                        Container(
                          height: 18,
                          width: 18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: const Center(
                            child: Text(
                              "A",
                              style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 18,),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          ":Z",
                          style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Right:',
                            style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_rounded,color: Colors.white,),
                        const SizedBox(
                          width: 82,
                        ),
                        Container(
                          height: 18,
                          width: 18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: const Center(
                            child: Text(
                              "B",
                              style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 18,),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          ":X",
                          style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Up   :',
                            style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.arrow_upward_rounded,color: Colors.white,),
                        const SizedBox(
                          width: 50,
                        ),
                        Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Start",
                              style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 18,),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          ":A",
                          style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Down :',
                            style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.arrow_downward_rounded,color: Colors.white,),
                        const SizedBox(
                          width: 50,
                        ),
                        Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Select",
                              style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 18,),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          ":S",
                          style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 70,
                  height: 23,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0,color: Colors.teal),
                    borderRadius: const BorderRadius.all(Radius.circular(20,),),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Text(
                            "B",
                            style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 18,),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Center(
                        child: Text(
                          "EXIT",
                          style: TextStyle(color: Colors. white,fontFamily: 'VT323', fontSize: 20,),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event){
        if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
          pressedFlutterBoyControlButton('Left');
        }else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
          pressedFlutterBoyControlButton('Right');
        }else if(event.isKeyPressed(LogicalKeyboardKey.arrowUp)){
          pressedFlutterBoyControlButton('Up');
        }else if(event.isKeyPressed(LogicalKeyboardKey.arrowDown)){
          pressedFlutterBoyControlButton('Down');
        }else if(event.isKeyPressed(LogicalKeyboardKey.keyZ)){
          pressedFlutterBoyControlButton('A');
        }else if(event.isKeyPressed(LogicalKeyboardKey.keyX)){
          pressedFlutterBoyControlButton('B');
        }else if(event.isKeyPressed(LogicalKeyboardKey.keyA)){
          pressedFlutterBoyControlButton('Start');
        }else if(event.isKeyPressed(LogicalKeyboardKey.keyS)){
          pressedFlutterBoyControlButton('Select');
        }
      },
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 580,
                    width: 420,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(75), //60
                        topLeft: Radius.circular(15), //10
                        topRight: Radius.circular(15), //10
                        bottomLeft: Radius.circular(15), //10
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.inner,
                          color: Colors.grey, //Colors.teal,
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: Offset(4, 4), //Offset(7, 15),
                        ),
                      ],
                      color: Color(0xFF57bcb2),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SwitcherButton(
                                size: 28,
                                value: false,
                                onColor: Colors.white,
                                offColor: const Color(0xFF004D40),
                                onChange: (value) {
                                  if (value == true) {
                                    setState(() {
                                      isFlutterBoySwitchedOn = true;
                                      currentScreen = 1;
                                      flutterBoyKeyNote(9,'play');
                                    });
                                  } else {
                                    setState(() {
                                      isFlutterBoySwitchedOn = false;
                                      currentScreen = 0;
                                      flutterBoyKeyNote(10,'play');
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 30, left: 30, bottom: 10),
                          child: Container(
                            height: 340,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40), //40
                                topLeft: Radius.circular(10), //10
                                topRight: Radius.circular(10), //10
                                bottomLeft: Radius.circular(10), //10
                              ),
                              color: Colors.black,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 10, bottom: 70),
                                  child: Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isFlutterBoySwitchedOn
                                          ? Colors.red
                                          : Colors.grey,
                                      boxShadow: [
                                        BoxShadow(
                                          color: isFlutterBoySwitchedOn
                                              ? Colors.red.withOpacity(0.6)
                                              : Colors.transparent,
                                          spreadRadius: 7,
                                          blurRadius: 7,
                                          offset: const Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 30, top: 20, bottom: 20),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10), //30
                                          topLeft: Radius.circular(10), //10
                                          topRight: Radius.circular(10), //10
                                          bottomLeft: Radius.circular(10), //10
                                        ),
                                      ),
                                      child: getCurrentScreenContents(), //!isFlutterBoySwitchedOn ? getScreen(1) :  getScreen(0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 30),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.teal.shade200,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurStyle: BlurStyle.inner,
                                      color: Colors.teal,
                                      spreadRadius: 0.5,
                                      blurRadius: 5,
                                      offset: Offset(5, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              pressedFlutterBoyControlButton('Up');
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurStyle: BlurStyle.inner,
                                                    color: Colors.black26,
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.arrow_drop_up,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              pressedFlutterBoyControlButton('Left');
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurStyle: BlurStyle.inner,
                                                    color: Colors.black26,
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.arrow_left,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              pressedFlutterBoyControlButton('Right');
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurStyle: BlurStyle.inner,
                                                    color: Colors.black26,
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.arrow_right,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              pressedFlutterBoyControlButton('Down');
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurStyle: BlurStyle.inner,
                                                    color: Colors.black26,
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  left: 10,
                                  top: 70,
                                  child: Transform(
                                    transform: Matrix4.rotationZ(-0.75),
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.teal.shade200,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurStyle: BlurStyle.inner,
                                            color: Colors.teal,
                                            spreadRadius: 0.5,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:10, left: 70, right: 10,),
                                      //top: 16, left: 84, right: 10,),
                                      child: GestureDetector(
                                        onTap: () {
                                          pressedFlutterBoyControlButton('A');
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                blurStyle: BlurStyle.inner,
                                                color: Colors.black26,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'A',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 23, right: 50, bottom: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          pressedFlutterBoyControlButton('B');
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                blurStyle: BlurStyle.inner,
                                                color: Colors.black26,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(1 , 1),
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'B',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform(
                                transform: Matrix4.rotationZ(-0.75),
                                child: GestureDetector(
                                  onTap: () {
                                    pressedFlutterBoyControlButton('Start');
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurStyle: BlurStyle.inner,
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 2.5),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Start',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Transform(
                                  transform: Matrix4.rotationZ(-0.75),
                                  child: GestureDetector(
                                    onTap: () {
                                      pressedFlutterBoyControlButton('Select');
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurStyle: BlurStyle.inner,
                                            color: Colors.black26,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(0, 2.5),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Select',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(110, 210, 0)
                            ..rotateZ(-0.80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 250, right: 10),
                                child: Container(
                                  height: 50,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 50,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 50,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 50,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 50,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
