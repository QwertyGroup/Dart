// Original video playlist
// https://www.youtube.com/watch?v=Ze00Ws7c-Qc&list=PLjr4ufdmNA4J2-KwMutexAjjf_VmjL1eH

import 'dart:ui';

import 'package:flutter/material.dart';

class WaveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WaveSlider(),
      ),
    );
  }
}

class WaveSlider extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  const WaveSlider({
    this.width = 350,
    this.height = 50,
    this.color = Colors.black,
  });

  @override
  _WaveSliderState createState() => _WaveSliderState();
}

class _WaveSliderState extends State<WaveSlider> {
  double _dragPosition = 0;
  double get _dragPercentage => _dragPosition / widget.width * 100;

  void _updateDragPosition(Offset offset) {
    double newDragPosition;
    if (offset.dx <= 0) {
      newDragPosition = 0;
    } else if (offset.dx >= widget.width) {
      newDragPosition = widget.width;
    } else {
      newDragPosition = offset.dx;
    }

    setState(() {
      _dragPosition = newDragPosition;
    });
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          width: widget.width,
          height: widget.height,
          child: CustomPaint(
            painter: WavePainter(
              color: widget.color,
              sliderPosition: _dragPosition,
              dragPercentage: _dragPercentage,
            ),
          ),
        ),
        onHorizontalDragUpdate: (update) => _onDragUpdate(context, update),
        onHorizontalDragStart: (start) => _onDragStart(context, start),
        onHorizontalDragEnd: (end) => _onDragEnd(context, end),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;

  final Color color;
  double _previousSliderPosition = 0;

  final Paint fillPainter;
  final Paint wavePainter;

  WavePainter({
    @required this.sliderPosition,
    @required this.dragPercentage,
    @required this.color,
  })  : fillPainter = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        wavePainter = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    _paintAnchors(canvas, size);
    // _paintLine(canvas, size);
    // _paintBlock(canvas, size);
    _paintWaveLine(canvas, size);
  }

  _paintAnchors(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0, size.height), 5, fillPainter);
    canvas.drawCircle(Offset(size.width, size.height), 5, fillPainter);
  }

  WaveCurveDefinitions _calculateWaveCurveDefinitions() {
    double bendWidth = 40;
    double bezierWidth = 40;

    double startOfBend = sliderPosition - bendWidth / 2;
    double endOfBend = sliderPosition + bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBezier = endOfBend + bezierWidth;

    double controlHeight = 0;
    double centerPoint = sliderPosition;

    double leftControlPoint1 = startOfBend;
    double leftControlPoint2 = startOfBend;
    double rightControlPoint1 = endOfBend;
    double rightControlPoint2 = endOfBend;

    double bendability = 25;
    double maxSlideDifference = 20;

    double slideDifference = (sliderPosition - _previousSliderPosition).abs();
    if (slideDifference > maxSlideDifference) {
      slideDifference = maxSlideDifference;
    }

    double bend = lerpDouble(
      0,
      bendability,
      slideDifference / maxSlideDifference,
    );

    bool moveLeft = sliderPosition < _previousSliderPosition;

    if (moveLeft) {
      leftControlPoint1 -= bend;
      leftControlPoint2 += bend;
      rightControlPoint1 += bend;
      rightControlPoint2 -= bend;
      centerPoint += bend;
    } else {
      leftControlPoint1 += bend;
      leftControlPoint2 -= bend;
      rightControlPoint1 -= bend;
      rightControlPoint2 += bend;
      centerPoint -= bend;
    }

    var waveCurve = WaveCurveDefinitions(
      startOfBezier: startOfBezier,
      endOfBezier: endOfBezier,
      leftControlPoint1: leftControlPoint1,
      leftControlPoint2: leftControlPoint2,
      rightControlPoint1: rightControlPoint1,
      rightControlPoint2: rightControlPoint2,
      controlHeight: controlHeight,
      centerPoint: centerPoint,
    );
    return waveCurve;
  }

  _paintWaveLine(Canvas canvas, Size size) {
    WaveCurveDefinitions waveCurve = _calculateWaveCurveDefinitions();

    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(waveCurve.startOfBezier, size.height)
      ..cubicTo(
          waveCurve.leftControlPoint1,
          size.height,
          waveCurve.leftControlPoint2,
          waveCurve.controlHeight,
          waveCurve.centerPoint,
          waveCurve.controlHeight)
      ..cubicTo(
          waveCurve.rightControlPoint1,
          waveCurve.controlHeight,
          waveCurve.rightControlPoint2,
          size.height,
          waveCurve.endOfBezier,
          size.height)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, wavePainter);
  }

  _paintLine(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  _paintBlock(Canvas canvas, Size size) {
    Rect rect = Offset(sliderPosition, size.height - 5) & Size(3, 10);
    canvas.drawRect(rect, fillPainter);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    _previousSliderPosition = oldDelegate.sliderPosition;
    return true;
  }
}

class WaveCurveDefinitions {
  final double startOfBezier;
  final double endOfBezier;
  final double leftControlPoint1;
  final double leftControlPoint2;
  final double rightControlPoint1;
  final double rightControlPoint2;
  final double controlHeight;
  final double centerPoint;

  WaveCurveDefinitions({
    this.startOfBezier,
    this.endOfBezier,
    this.leftControlPoint1,
    this.leftControlPoint2,
    this.rightControlPoint1,
    this.rightControlPoint2,
    this.controlHeight,
    this.centerPoint,
  });
}
