import 'package:flutter/material.dart';

class DiceFace extends StatelessWidget {
  final int value;
  final Color dotColor;
  final BoxDecoration faceDecoration;
  final double size;

  const DiceFace({
    Key key,
    this.value = 1,
    this.dotColor,
    this.faceDecoration,
    this.size,
  }) : super(key: key);

  _getFace() {
    switch (value) {
      case 1:
        return _faceOne();
      case 2:
        return _faceTwo();
      case 3:
        return _faceThree();
      case 4:
        return _faceFour();
      case 5:
        return _faceFive();
      case 6:
        return _faceSix();
      default:
    }
  }

  _faceOne() {
    return dot;
  }

  _faceTwo() {
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Row(
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox(), flex: 3),
          ],
        ),
        Expanded(child: SizedBox(), flex: 2),
        Row(
          children: [
            Expanded(child: SizedBox(), flex: 3),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  _faceThree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: SizedBox()),
        Row(
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox(), flex: 3),
          ],
        ),
        Expanded(child: SizedBox()),
        Row(
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
        Row(
          children: [
            Expanded(child: SizedBox(), flex: 3),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  _faceFour() {
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox(), flex: 2),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox(), flex: 2),
        Row(
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox(), flex: 2),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  _faceFive() {
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox(), flex: 2),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
        dot,
        Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox(), flex: 2),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  _faceSix() {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox(), flex: 2),
        Column(
          children: [
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox()),
            dot,
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  Widget get dot {
    return Container(
      decoration: BoxDecoration(
        color: dotColor ?? Colors.grey,
        shape: BoxShape.circle,
      ),
      height: size / 6,
      width: size / 6,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: faceDecoration == null ? Colors.white : null,
      decoration: faceDecoration,
      alignment: Alignment.center,
      child: _getFace(),
    );
  }
}
