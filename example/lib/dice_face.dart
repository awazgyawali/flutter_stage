import 'package:flutter/material.dart';

class DiceFace extends StatelessWidget {
  final int value;

  const DiceFace({Key key, this.value = 1}) : super(key: key);

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
    return DiceDot();
  }

  _faceTwo() {
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Row(
          children: [
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox(), flex: 3),
          ],
        ),
        Expanded(child: SizedBox(), flex: 2),
        Row(
          children: [
            Expanded(child: SizedBox(), flex: 3),
            DiceDot(),
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
            DiceDot(),
            Expanded(child: SizedBox(), flex: 3),
          ],
        ),
        Expanded(child: SizedBox()),
        Row(
          children: [
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
        Row(
          children: [
            Expanded(child: SizedBox(), flex: 3),
            DiceDot(),
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
            DiceDot(),
            Expanded(child: SizedBox(), flex: 2),
            DiceDot(),
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox(), flex: 2),
        Row(
          children: [
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox(), flex: 2),
            DiceDot(),
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
            DiceDot(),
            Expanded(child: SizedBox(), flex: 2),
            DiceDot(),
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
        DiceDot(),
        Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox(), flex: 2),
            DiceDot(),
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  _faceSix() {
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox(), flex: 2),
        Row(
          children: [
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox()),
            DiceDot(),
            Expanded(child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: _getFace(),
    );
  }
}

class DiceDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      height: 100,
      width: 100,
    );
  }
}
