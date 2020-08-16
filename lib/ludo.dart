import 'dart:ui';

import 'dice_face.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stage/flutter_stage.dart';

class LudoDice extends StatefulWidget {
  final int roll;
  final Curve curve;
  final double size;
  final Color dotColor;
  final Duration duration;
  final bool shouldAnimateInitially;
  final BoxDecoration faceDecoration;

  const LudoDice({
    Key key,

    /// The rface of the dice that should be rolled to
    @required this.roll,

    /// The duration of each roll
    @required this.duration,

    /// Send [true] if you want to roll the dice for the first time. Default is [false]
    this.shouldAnimateInitially = false,

    /// Decoration for the faces of the dice, if nothing is provided then plain white background will be used.
    this.faceDecoration,

    /// Color of the dots on the face of dice
    this.dotColor,

    /// Curve for the animation. Default is [Curves.easeInOutSine]
    this.curve = Curves.easeInOutQuart,

    /// Size of the dice to be rendered. Default is [300]
    this.size = 300,
  }) : super(key: key);
  @override
  _LudoDiceState createState() => _LudoDiceState();
}

class _LudoDiceState extends State<LudoDice>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _curvedAnimation;
  AnimationStatus _animationStatus;

  Vector3 _target, _currentRotation, _lastRotation, _stop;

  int _currentRoll;

  @override
  void initState() {
    super.initState();
    _currentRoll = 1;
    _currentRotation = _evenRoles[_currentRoll];
    _lastRotation = Vector3.copy(_currentRotation);
    _animationStatus = AnimationStatus.completed;
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: widget.duration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    )
      ..addListener(() {
        double value = _curvedAnimation.value;
        setState(() {
          _currentRotation = Vector3(
            _lerpDoubleWithStops(
              _lastRotation.x,
              _target.x,
              value,
              stop: _stop.x,
            ),
            _lerpDoubleWithStops(
              _lastRotation.y,
              _target.y,
              value,
              stop: _stop.y,
            ),
            _lerpDoubleWithStops(
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
          _lastRotation = Vector3.copy(_evenRoles[_currentRoll]);
        _animationStatus = status;
      });

    if (widget.shouldAnimateInitially) _startAnimation(widget.roll);
  }

  _startAnimation(int roll) async {
    _currentRoll = roll;
    _stop = _oddRoles[roll];
    _target = _evenRoles[roll];
    _animationController.forward(from: 0);
  }

  @override
  void didUpdateWidget(LudoDice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_animationStatus != AnimationStatus.completed)
      print("Dice is already animating!!!");
    else
      _startAnimation(widget.roll);
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

/// This is an helper function to interpolate [start] and [end] value with a [stop] valuee
double _lerpDoubleWithStops(
  double start,
  double end,
  double value, {
  double stop,
}) {
  if (stop == null) return lerpDouble(start, end, value);
  if (value < 0.5)
    return lerpDouble(start, stop, value * 2);
  else if (value > .5) return lerpDouble(stop, end, (value - .5) * 2);
  return stop;
}

List<Vector3> get _oddRoles => [
      null,
      Vector3(-360, -720, -360),
      Vector3(-360, -810, -360),
      Vector3(-360, -900, -360),
      Vector3(-360, -630, -360),
      Vector3(-450, -720, -360),
      Vector3(-270, -720, -360),
    ];

List<Vector3> get _evenRoles => [
      null,
      Vector3(360, 720, 360),
      Vector3(360, 630, 360),
      Vector3(360, 900, 360),
      Vector3(360, 810, 360),
      Vector3(270, 720, 360),
      Vector3(450, 720, 360),
      Vector3(360, 810, 360),
    ];
