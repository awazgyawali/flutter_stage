import 'dart:ui';

import 'package:example/animations.dart';
import 'package:example/helpers.dart';

import 'dice_face.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stage/flutter_stage.dart';

class LudoDice extends StatefulWidget {
  final Duration duration;
  final int initialRoll;
  final Color dotColor;
  final Curve curve;
  final double size;
  final BoxDecoration faceDecoration;

  const LudoDice({
    /// [key] is required to get function that will animate the changes
    @required Key key,

    /// The duration of each roll
    @required this.duration,

    /// The face of the dice for the first render. Default is 1
    this.initialRoll = 1,

    /// Decoration for the faces of the dice, if nothing is provided then plain white background will be used.
    this.faceDecoration,

    /// Color of the dots on the face of dice
    this.dotColor,

    /// Curve for the animation. Default is [Curves.easeInOutSine]
    this.curve = Curves.easeInOutBack,

    /// Size of the dice to be rendered. Default is [300]
    this.size = 300,
  }) : super(key: key);
  @override
  LudoDiceState createState() => LudoDiceState();
}

class LudoDiceState extends State<LudoDice>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Vector3 _target, _currentRotation, _lastRotation, _stop;

  int currentRoll;

  @override
  void initState() {
    super.initState();
    currentRoll = 1;
    _currentRotation = evenRoles[currentRoll];
    _lastRotation = Vector3.copy(_currentRotation);
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: widget.duration,
    );

    CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    )
      ..addListener(() {
        double value = _animationController.value;
        setState(() {
          _currentRotation = Vector3(
            lerpDoubleWithStops(
              _lastRotation.x,
              _target.x,
              value,
              stop: _stop.x,
            ),
            lerpDoubleWithStops(
              _lastRotation.y,
              _target.y,
              value,
              stop: _stop.y,
            ),
            lerpDoubleWithStops(
              _lastRotation.z,
              _target.z,
              value,
              stop: _stop.z,
            ),
          );
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          _lastRotation = Vector3.copy(evenRoles[currentRoll]);
      });
  }

  _startAnimation(int roll) async {
    currentRoll = roll;
    _stop = oddRoles[roll];
    _target = evenRoles[roll];
    _animationController.forward(from: 0);
  }

  rollDiceTo(int roll) {
    _startAnimation(roll);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Stage(
        interactive: true,
        onSceneCreated: (Scene scene) async {
          scene.camera.position.setFrom(Vector3(0, 0, widget.size * 1.5));
          scene.camera.updateTransform();
        },
        children: [
          Actor(
            rotation: _currentRotation,
            children: [
              Actor(
                position: Vector3(0, 0, widget.size / 2),
                rotation: Vector3(0, 0, 0),
                height: widget.size,
                width: widget.size,
                widget: DiceFace(
                  value: 1,
                  faceDecoration: widget.faceDecoration,
                  size: widget.size,
                  dotColor: widget.dotColor,
                ),
              ),
              Actor(
                position: Vector3(widget.size / 2, 0, 0),
                rotation: Vector3(0, 90, 0),
                height: widget.size,
                width: widget.size,
                widget: DiceFace(
                  value: 2,
                  faceDecoration: widget.faceDecoration,
                  size: widget.size,
                  dotColor: widget.dotColor,
                ),
              ),
              Actor(
                position: Vector3(0, 0, -widget.size / 2),
                rotation: Vector3(0, 180, 0),
                height: widget.size,
                width: widget.size,
                widget: DiceFace(
                  value: 3,
                  faceDecoration: widget.faceDecoration,
                  dotColor: widget.dotColor,
                  size: widget.size,
                ),
              ),
              Actor(
                position: Vector3(-widget.size / 2, 0, 0),
                rotation: Vector3(0, 270, 0),
                height: widget.size,
                width: widget.size,
                widget: DiceFace(
                  value: 4,
                  faceDecoration: widget.faceDecoration,
                  dotColor: widget.dotColor,
                  size: widget.size,
                ),
              ),
              Actor(
                position: Vector3(0, -widget.size / 2, 0),
                rotation: Vector3(90, 0, 0),
                height: widget.size,
                width: widget.size,
                widget: DiceFace(
                  value: 5,
                  faceDecoration: widget.faceDecoration,
                  dotColor: widget.dotColor,
                  size: widget.size,
                ),
              ),
              Actor(
                position: Vector3(0, widget.size / 2, 0),
                rotation: Vector3(270, 0, 0),
                height: widget.size,
                width: widget.size,
                widget: DiceFace(
                  value: 6,
                  faceDecoration: widget.faceDecoration,
                  dotColor: widget.dotColor,
                  size: widget.size,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
