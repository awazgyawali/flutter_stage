import 'dart:ui';

import 'package:example/animations.dart';

import 'dice_face.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stage/flutter_stage.dart';

class LudoDice extends StatefulWidget {
  final int roll;
  final Duration duration;
  final bool animateAtStart;
  final int initalValue;

  const LudoDice({
    Key key,
    @required this.roll,
    @required this.duration,
    this.initalValue = 1,
    this.animateAtStart = false,
  })  : assert(roll > 0 && roll < 7),
        super(key: key);
  @override
  _LudoDiceState createState() => _LudoDiceState();
}

class _LudoDiceState extends State<LudoDice>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Scene _scene;
  Vector3 _lastPosition = Vector3(0, 0, 1400);
  Animation<double> tween;

  List<Vector3> _dicePosition = [
    null,
    Vector3(0, 0, 1400),
    Vector3(1400, 0, 0),
    Vector3(0, 0, -1400),
    Vector3(-1400, 0, 0),
    Vector3(0, -1400, 45),
    Vector3(0, 1400, 90),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: widget.duration,
    );

    _animationController.addListener(() {
      double _value = _animationController.value;
      Vector3 target = _dicePosition[widget.roll];
      _scene.camera.position.setFrom(
        Vector3(
          lerpDouble(_lastPosition.x, target.x, _value),
          lerpDouble(_lastPosition.y, target.y, _value),
          lerpDouble(_lastPosition.z, target.z, _value),
        ),
      );
      setState(() {
        _scene.camera.updateTransform();
      });
      print(tween.value);
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _lastPosition = _scene.camera.position;
    });
  }

  _startAnimation(List<List<int>> paths) {
    print("this should animate to ${widget.roll}");

    _animationController.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(LudoDice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.roll != oldWidget.roll)
      _startAnimation(getAnimationPaths(oldWidget.roll, widget.roll, 7));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Stage(
        onSceneCreated: (Scene scene) async {
          this._scene = scene;
          _scene.camera.position.setFrom(_lastPosition);
          _scene.camera.updateTransform();
        },
        children: [
          Actor(
            children: [
              Actor(
                position: Vector3(0, 0, 300),
                rotation: Vector3(0, 0, 0),
                width: 600,
                height: 600,
                widget: DiceFace(value: 1),
              ),
              Actor(
                position: Vector3(300, 0, 0),
                rotation: Vector3(0, 90, 0),
                width: 600,
                height: 600,
                widget: DiceFace(value: 2),
              ),
              Actor(
                position: Vector3(0, 0, -300),
                rotation: Vector3(0, 180, 0),
                width: 600,
                height: 600,
                widget: DiceFace(value: 3),
              ),
              Actor(
                position: Vector3(-300, 0, 0),
                rotation: Vector3(0, 270, 0),
                width: 600,
                height: 600,
                widget: DiceFace(value: 4),
              ),
              Actor(
                position: Vector3(0, -300, 0),
                rotation: Vector3(90, 0, 0),
                width: 600,
                height: 600,
                widget: DiceFace(value: 5),
              ),
              Actor(
                position: Vector3(0, 300, 0),
                rotation: Vector3(270, 0, 0),
                width: 600,
                height: 600,
                widget: DiceFace(value: 6),
              )
            ],
          ),
        ],
      ),
    );
  }
}
