import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Screenv2 extends StatefulWidget {
  const Screenv2({Key? key}) : super(key: key);

  @override
  _Screenv2State createState() => _Screenv2State();
}

class _Screenv2State extends State<Screenv2> {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
  // List<int> numbers = [8, 2, 9, 4, 5, 10, 7, 1, 3, 6, 0, 12, 11, 14, 15, 13];
  bool isEmpty = true;
  int move = 0;

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


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

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
                height: 590,
                width: 425,
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
                    const Divider(
                      color: Colors.black,
                      thickness: 12.5,
                      indent: 150,
                      endIndent: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, right: 30, left: 30, bottom: 10),
                      child: Container(
                        height: 350,
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
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.6),
                                      spreadRadius: 7,
                                      blurRadius: 7,
                                      offset: Offset(
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
                                      bottomRight: Radius.circular(30),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    color: Colors.amberAccent,
                                  ),
                                  child:
                                  //TODO:FixAnimations
                                  // AnimatedTextKit(
                                  //   onFinished: () {
                                  //   },
                                  //   totalRepeatCount: 1,
                                  //   animatedTexts: [
                                  //     ColorizeAnimatedText(
                                  //       'FLUTTERBOY',
                                  //       textStyle: colorizeTextStyle,
                                  //       colors: colorizeColors,
                                  //       speed: Duration(milliseconds: 300),
                                  //     ),
                                  //   ],
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 10, bottom: 5),
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                        // childAspectRatio: 1.4,
                                      ),
                                      itemCount: numbers.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (numbers[index] != 0) {
                                          return GestureDetector(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < results[index]!.length;
                                                  i++) {
                                                int index2 = results[index]![i];
                                                if (numbers[index2] == 0) {
                                                  setState(() {
                                                    numbers[index2] =
                                                        numbers[index];
                                                    numbers[index] = 0;
                                                    move++;
                                                  });
                                                }
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'images/dash_' +
                                                          numbers[index]
                                                              .toString() +
                                                          '.jpg'),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              child: Text(
                                                  numbers[index].toString()),
                                            ),
                                          );
                                        }
                                        return SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                  offset: Offset(6, 10),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: const FaIcon(
                                FontAwesomeIcons.plus,
                                color: Colors.black,
                                size: 85,
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          //TODO:Tilt the buttons a bit more
                          children: [
                            Positioned(
                              left: 69,
                              child: Transform(
                                transform: Matrix4.skew(53, 0),
                                child: Container(
                                  height: 95,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.teal.shade200,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(30),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurStyle: BlurStyle.inner,
                                        color: Colors.teal,
                                        spreadRadius: 0.5,
                                        blurRadius: 5,
                                        offset: Offset(6, 10),
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
                                      top: 5, left: 70, right: 20, bottom: 5),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35, right: 30, bottom: 5),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 30, right: 30, bottom: 10),
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
                                  offset: Offset(3, 6),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 30, right: 30, bottom: 10),
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
                                  offset: Offset(3, 6),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
