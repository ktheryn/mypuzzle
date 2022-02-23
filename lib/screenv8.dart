import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:rive/rive.dart';
import 'package:lottie/lottie.dart';

class Screenv8 extends StatefulWidget {
  const Screenv8({Key? key}) : super(key: key);

  @override
  _Screenv8State createState() => _Screenv8State();
}

class _Screenv8State extends State<Screenv8> {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
  // List<int> numbers = [8, 2, 9, 4, 5, 10, 7, 1, 3, 6, 0, 12, 11, 14, 15, 13];
  bool isEmpty = true;
  bool isFlutterBoySwitchedOn = false;
  int move = 0;
  bool isFinished = false;
  int screenValue = 4;


  //List<int> screen = [0, 1, 2];

  Map<int, int> screenOption = {
    //Currently selected option on current screen [screen:current option]
    0: 0,
    1: 0,
    2: 1,
  };

  Map<int, List<int>> results = {
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

  List<MaterialColor> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Cabin',
  );

  getScreen() {
    if (screenValue == 0) {
      return Container(
        color: Color(0xFF9CA04C),
      );
    } else if (screenValue == 1) {
      return Container(
        color: Colors.white,
        height: 350,
        child: Center(
          child: AnimatedTextKit(
            //TODO:Fixed Animations
            onFinished: () {
              setState(() {
                isFlutterBoySwitchedOn = true;
                screenValue = 2;
              });
            },
            totalRepeatCount: 1,
            animatedTexts: [
              ColorizeAnimatedText(
                'FLUTTERBOY',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
                speed: Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      );
    } else if (screenValue == 2) {
      return Container(
          color: Colors.white,
          height: 350,
          //TODO: ANIMATION
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sliders Game',
                  style: TextStyle(fontFamily: 'VT323', fontSize: 45),
                ),
              ),
              Expanded(
                child: Center(
                  child: RiveAnimation.asset(
                    //'assets/6cubescont.riv',
                    'assets/6cubes.riv',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3.0,
                          color: screenOption[screenValue] == 1
                              ? Colors.teal
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Start',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'VT323',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3.0,
                          color: screenOption[screenValue] == 2
                              ? Colors.teal
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Controls',
                        style: TextStyle(fontFamily: 'VT323', fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    } else if (screenValue == 3) {
      return Container(
        color: Colors.grey,
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 7.5, bottom: 7.5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                //childAspectRatio: 1.2,
              ),
              itemCount: numbers.length,
              itemBuilder: (BuildContext context, int index) {
                if (numbers[index] != 0) {
                  return GestureDetector(
                    onTap: () {
                      for (int i = 0; i < results[index]!.length; i++) {
                        int index2 = results[index]![i];
                        if (numbers[index2] == 0) {
                          setState(() {
                            numbers[index2] = numbers[index];
                            numbers[index] = 0;
                            move++;
                          });
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('images/dash_' +
                              numbers[index].toString() +
                              '.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      // child: Text(numbers[index].toString()),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      //TODO: Fix Confetti
    } else if (screenValue == 4) {
      return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Lottie.asset('assets/lottie3.json', repeat: false),
            Column(
              children: [
                Text(
                  'You just got Lucky!',
                  style: TextStyle(fontFamily: 'VT323', fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.teal,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Retry',
                          style: TextStyle(fontFamily: 'VT323', fontSize: 30),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.teal,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Home',
                          style: TextStyle(fontFamily: 'VT323', fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  void getToggle(index) {
    if (index == 0) {
      isFlutterBoySwitchedOn = true;
    } else {
      isFlutterBoySwitchedOn = false;
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
      onKey: (event) {
        //TODO: Keyboard Keys
        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          print("Up");
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          print("Down");
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          if (screenValue == 2) {
            print("Left");
            setState(() {
              screenOption[screenValue] = 1;
            });
          }
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          if (screenValue == 2) {
            print("Right");
            setState(() {
              screenOption[screenValue] = 2;
            });
          }
        } else if (event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
          if (screenValue == 2) {
            if (screenOption[screenValue] == 1) {
              setState(() {
                screenValue = 3;
              });
            } else if (screenOption[screenValue] == 2) {
              print("A Screen2");
            }
          }
        } else if (event.isKeyPressed(LogicalKeyboardKey.keyX)) {
          print("B");
        } else if (event.isKeyPressed(LogicalKeyboardKey.keyA)) {
          print("Start");
        } else if (event.isKeyPressed(LogicalKeyboardKey.keyS)) {
          print("Select");
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 580,
                    width: 420, //TODO: part 1
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
                            //TODO:TOGGLESWITCH
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SwitcherButton(
                                size: 28,
                                value: false,
                                onColor: Colors.white,
                                offColor: Color(0xFF004D40),
                                onChange: (value) {
                                  if (value == true) {
                                    setState(() {
                                      isFlutterBoySwitchedOn = true;
                                      screenValue = 1;
                                    });
                                  } else {
                                    setState(() {
                                      isFlutterBoySwitchedOn = false;
                                      screenValue = 0;
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
                            height: 340, //TODO: part 2
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
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 70),
                                  child: Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isFlutterBoySwitchedOn
                                          ? Colors.red
                                          : Colors.grey,
                                      boxShadow: [
                                        //TODO:REDLIGHT
                                        BoxShadow(
                                          color: isFlutterBoySwitchedOn
                                              ? Colors.red.withOpacity(0.6)
                                              : Colors.transparent,
                                          spreadRadius: 7,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //TODO: FixScreen
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 30,
                                        top: 20,
                                        bottom: 20),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10), //30
                                          topLeft: Radius.circular(10), //10
                                          topRight: Radius.circular(10), //10
                                          bottomLeft: Radius.circular(10), //10
                                        ),
                                        //color: Colors.amberAccent,//TODO:Color background
                                      ),
                                      child:
                                          getScreen(), //!isFlutterBoySwitchedOn ? getScreen(1) :  getScreen(0),
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
                                  boxShadow: [
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
                                          Container(
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
                                            child: Icon(
                                              Icons.arrow_drop_up,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (screenValue == 2) {
                                                setState(() {
                                                  screenOption[screenValue] = 1;
                                                });
                                              }
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
                                              child: Icon(
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
                                            onTap: () {
                                              if (screenValue == 2) {
                                                setState(() {
                                                  screenOption[screenValue] = 2;
                                                });
                                              }
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
                                              child: Icon(
                                                Icons.arrow_right,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
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
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
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
                              //TODO:Tilt the buttons a bit more
                              children: [
                                Positioned(
                                  //TODO: Fixed Button A & B part 3
                                  right: 0,
                                  left: 10, //30
                                  top: 70, //70
                                  //TODO:fix the slant
                                  child: Transform(
                                    transform: Matrix4.rotationZ(-0.75),
                                    child: Container(
                                      height: 50,
                                      width: 100, //100
                                      decoration: BoxDecoration(
                                        color: Colors.teal.shade200,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                        boxShadow: [
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
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 70,
                                        right: 10,
                                      ), //TODO: Fixed Button A & B part 1
                                      //top: 16, left: 84, right: 10,),
                                      child: GestureDetector(
                                        onTap: () {
                                          print('button A');
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
                                          child: Center(
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
                                      padding: const EdgeInsets.only(
                                          left: 23,
                                          right: 50,
                                          bottom:
                                              20), //TODO: Fixed Button A & B part 2
                                      // left: 40, right: 40, bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          print('Button B');
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
                                          child: Center(
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
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform(
                                transform: Matrix4.rotationZ(-0.75),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 20,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurStyle: BlurStyle.inner,
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 2.5),
                                        ),
                                      ],
                                    ),
                                    child: Center(
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
                                      print('Yemen');
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.inner,
                                            color: Colors.black26,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(0, 2.5),
                                          ),
                                        ],
                                      ),
                                      child: Center(
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
                  SizedBox(
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


