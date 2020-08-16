import 'dart:math';

import 'package:flutter/material.dart';
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
          Container(
            child: LudoDice(
              size: 200,
              roll: roll,
              dotColor: Colors.orange,
              shouldAnimateInitially: false,
              duration: Duration(milliseconds: 2000),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                roll = Random().nextInt(5) + 1;
              });
            },
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              color: Colors.yellow,
              child: Text("Roll the dice!!!"),
            ),
          ),
        ],
      ),
    );
  }
}
