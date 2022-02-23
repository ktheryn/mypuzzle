import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Screenv5 extends StatefulWidget {
  const Screenv5({Key? key}) : super(key: key);

  @override
  _Screenv5State createState() => _Screenv5State();
}

class _Screenv5State extends State<Screenv5> {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
  // List<int> numbers = [8, 2, 9, 4, 5, 10, 7, 1, 3, 6, 0, 12, 11, 14, 15, 13];
  bool isEmpty = true;
  bool isFlutterBoySwitchedOn = false;
  int move = 0;
  bool isFinished = false;

  List<int> screen = [0, 1, 2, 3];

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

  getScreen(screen) {
    if (screen == 0) {
      return Container(
        color: Colors.black87,
      );
    } else if (screen == 1) {
      return Container(
        height: 350,
        child: Center(
          child: AnimatedTextKit(
            //TODO:Fixed Animations
            onFinished: () {
              // setState(() {
              //   isFlutterBoySwitchedOn = true;
              // });
            },
            totalRepeatCount: 1,
            animatedTexts: [
              ColorizeAnimatedText(
                'FLUTTERBOY',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
                speed: Duration(milliseconds: 500),
              ),
            ],
          ),
        ),
      );
    } else if (screen == 2) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
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
                      image: AssetImage(
                          'images/dash_' + numbers[index].toString() + '.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(numbers[index].toString()),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    int toggleIndex = 0;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
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
                    bottomRight: Radius.circular(60),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.inner,
                      color: Colors.teal,
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: Offset(7, 15),
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
                          child: ToggleSwitch(
                            minWidth: 10.0,
                            minHeight: 10,
                            cornerRadius: 10.0,
                            activeBgColors: [
                              [Colors.green[800]!],
                              [Colors.red[800]!]
                            ],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            initialLabelIndex: 0,
                            totalSwitches: 2,
                            // labels: ['ON', 'OFF'],
                            // fontSize: 10,
                            radiusStyle: true,
                            onToggle: (index) {
                              print('switched to: $index');

                              if (index == 0) {
                                setState(() {
                                  isFlutterBoySwitchedOn = true;
                                });
                              } else {
                                setState(() {
                                  isFlutterBoySwitchedOn = false;
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
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
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
                                  color: !isFlutterBoySwitchedOn ? Colors.red : Colors.grey,
                                  boxShadow: [
                                    //TODO:REDLIGHT
                                    BoxShadow(
                                      color: !isFlutterBoySwitchedOn
                                          ? Colors.red.withOpacity(0.6)
                                          : Colors.transparent,
                                      spreadRadius: 7,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //TODO: FixScreen
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 30, top: 20, bottom: 20),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    color: Colors.amberAccent,
                                  ),
                                  child: !isFlutterBoySwitchedOn ? getScreen(1) :  getScreen(0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.teal.shade100,
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         'FLUTTERBOY',
                    //         style: TextStyle(
                    //             fontSize: 10,
                    //             fontFamily: 'Cabin',
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),),
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
                                        ),
                                        child: Icon(Icons.arrow_drop_up,color: Colors.white,),
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
                                        ),
                                        child: Icon(Icons.arrow_left,color: Colors.white,),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                        child: Icon(Icons.arrow_right,color: Colors.white,),
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
                                        ),
                                        child: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // child: const FaIcon(
                              //   FontAwesomeIcons.plus,
                              //   color: Colors.black,
                              //   size: 80,
                              // ),
                            ),
                          ),
                        ),
                        Stack(
                          //TODO:Tilt the buttons a bit more
                          children: [
                            Positioned(
                              left: 30,
                              top: 70,
                              //TODO:fix the slant
                              child: Transform(
                                transform: Matrix4.rotationZ(-0.95),
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
                                      top: 4, left: 73, right: 20),
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
                                      left: 35, right: 40, bottom: 10),
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
                          Center(
                            child: Transform(
                              transform: Matrix4.rotationZ(-0.95),
                              child: GestureDetector(
                                onTap: () {
                                  print('yahoo');
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
                                        spreadRadius: 0.5,
                                        blurRadius: 5,
                                        offset: Offset(0, 5),
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
                          ),
                          Center(
                            child: Transform(
                              transform: Matrix4.rotationZ(-0.95),
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
                                        spreadRadius: 0.5,
                                        blurRadius: 5,
                                        offset: Offset(0, 5),
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
    );
  }
}
