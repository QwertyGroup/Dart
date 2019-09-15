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

  _paintWaveLine(Canvas canvas, Size size) {
    double bendWidth = 40;
    double bezierWidth = 40;

    double startOfBend = sliderPosition - bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBend = sliderPosition + bendWidth / 2;
    double endOfBezier = endOfBend + bezierWidth;

    double controlHeight = 0;
    double centerPoint = sliderPosition;

    double leftControlPoint1 = startOfBend;
    double leftControlPoint2 = startOfBend;
    double rightControlPoint1 = endOfBend;
    double rightControlPoint2 = endOfBend;

    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(
        startOfBezier,
        size.height,
      )
      ..cubicTo(
        leftControlPoint1,
        size.height,
        leftControlPoint2,
        controlHeight,
        centerPoint,
        controlHeight,
      )
      ..cubicTo(
        rightControlPoint1,
        controlHeight,
        rightControlPoint2,
        size.height,
        endOfBezier,
        size.height,
      )
      ..lineTo(
        size.width,
        size.height,
      );

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
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
