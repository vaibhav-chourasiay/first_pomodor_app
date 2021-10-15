import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoroapp/utilites/mycolors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int mvalue = 25;
  int secvalue = mvalue * 60;
  var percentvlaue = 0.0;
  bool t = false;
  bool m = false;
  int sk = 1;

  showvalue() {
    sk = 1;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (secvalue > 0 && mvalue > 0) {
        if (m == false) {
          if (secvalue % 60 == 0) {
            mvalue--;
          }
          if (secvalue % 100 == 0) {
            percentvlaue = percentvlaue + 0.01;
          }
          secvalue--;
        }
      } else if (sk == 0) {
        timer.cancel();
      } else {
        timer.cancel();
        mvalue = 5;
        secvalue = mvalue * 60;
        showvalue();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.c2,
      appBar: AppBar(
        title: "Pomodoro App".text.xl4.bold.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              child: CircularPercentIndicator(
                  radius: 250.0,
                  animation: true,
                  lineWidth: 10,
                  percent: percentvlaue,
                  progressColor: Vx.emerald200,
                  center: "${mvalue}m".text.bold.xl6.white.make()),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.greenAccent]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VxArc(
                          height: 10.0,
                          arcType: VxArcType.CONVEY,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Vx.red200,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                "Start Timer".text.xl2.bold.make(),
                                "${secvalue}s".text.xl4.bold.make()
                              ],
                            ),
                          ),
                        ),
                        VxArc(
                          height: 10.0,
                          arcType: VxArcType.CONVEY,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                              color: Vx.emerald200,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                "Break".text.xl2.bold.make(),
                                "5".text.xl4.bold.make()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            if (t == false) {
                              t = true;

                              setState(() {});
                              showvalue();
                            } else {
                              m = !m;
                              setState(() {});
                            }
                          },
                          child: Icon(Icons.play_arrow),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              mvalue = 25;
                              secvalue = mvalue * 60;
                              percentvlaue = 0.0;

                              sk = 0;
                            });
                          },
                          child: Icon(
                            Icons.repeat,
                            color: MyColors.c2,
                          ),
                          backgroundColor: Colors.greenAccent,
                        )
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
