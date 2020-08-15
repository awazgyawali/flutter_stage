import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_stage/flutter_stage.dart';
import 'ludo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stage',
      home: MyHomePage(title: 'Flutter Stage Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Scene scene;
  int roll = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.red,
              child: LudoDice(
                roll: roll,
                animateAtStart: false,
                duration: Duration(milliseconds: 400),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      roll = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child: Text("1"),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      roll = 2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child: Text("2"),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      roll = 3;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child: Text("3"),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      roll = 4;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child: Text("4"),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      roll = 5;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child: Text("5"),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      roll = 6;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child: Text("6"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
