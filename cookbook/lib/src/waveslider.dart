// Original video playlist
// https://www.youtube.com/watch?v=Ze00Ws7c-Qc&list=PLjr4ufdmNA4J2-KwMutexAjjf_VmjL1eH

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/services.dart';

class WaveApp extends StatefulWidget {
  @override
  _WaveAppState createState() => _WaveAppState();
}

class _WaveAppState extends State<WaveApp> {
  final _notifications = FlutterLocalNotificationsPlugin();
  int _age = 0;
  bool _notificationsOn = false;

  @override
  void initState() {
    super.initState();
    final settingAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));
    _notifications.initialize(
        InitializationSettings(settingAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    return Future.sync(() {
      print(payload);
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text(
                'Select your age',
                style: TextStyle(fontSize: 45, fontFamily: 'Exo'),
              ),
              WaveSlider(
                onChanged: (double val) =>
                    setState(() => _age = (val * 100).round()),
                onSelected: (double val) {
                  if (!_notificationsOn) return;
                  final age = (val * 100).round();

                  final androidNotificationDetails = AndroidNotificationDetails(
                    'channel id',
                    'channel name',
                    'channel desc',
                    importance: Importance.High,
                    priority: Priority.High,
                    ongoing: true,
                    // indeterminate: true,
                    // icon: '@drawable/app_icon',
                    // largeIcon: '@drawable/app_icon',
                    showProgress: true,
                    progress: age,
                    maxProgress: 100,
                    autoCancel: false,
                    // channelShowBadge: true,
                    color: Colors.red,
                  );
                  final iOSNotificationDetails = IOSNotificationDetails();
                  final notificationDetails = NotificationDetails(
                      androidNotificationDetails, iOSNotificationDetails);
                  _notifications.show(
                      0, 'WaveLine', 'Your age $age', notificationDetails);
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '$_age',
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'YEARS',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'TextMeOne',
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Toggle notifications',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Exo',
                    ),
                  ),
                  Switch(
                    value: _notificationsOn,
                    onChanged: (val) {
                      setState(() {
                        _notificationsOn = val;
                        // print(val);
                      });
                    },
                  ),
                ],
              ),
            ],
            // mainAxisSize: MainAxisSize.max,
          ),
        ),
      ),
    );
  }
}

class WaveSlider extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  final ValueChanged<double> onChanged;
  final ValueChanged<double> onSelected;

  const WaveSlider({
    this.width = 350,
    this.height = 50,
    this.color = Colors.black,
    this.onSelected,
    @required this.onChanged,
  }) : assert(height >= 50 && height <= 600);

  @override
  _WaveSliderState createState() => _WaveSliderState();
}

class _WaveSliderState extends State<WaveSlider>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  double get _dragPercentage => _dragPosition / widget.width;

  WaveSliderController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController = WaveSliderController(vsync: this)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

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

  _handleChangeUpdate(double val) {
    widget.onChanged?.call(val);
  }

  _handleSelected(double val) {
    widget.onSelected?.call(val);
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(update.globalPosition);
    _slideController.setStateToSliding();
    _updateDragPosition(offset);
    _handleChangeUpdate(_dragPercentage);
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(start.globalPosition);
    _slideController.setStateToStarting();
    _updateDragPosition(offset);
    _handleChangeUpdate(_dragPercentage);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    _slideController.setStateToStopping();
    _handleSelected(_dragPercentage);
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
              animationProgress: _slideController.progress,
              sliderState: _slideController.state,
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

  final double animationProgress;
  final SliderState sliderState;

  final Color color;
  double _previousSliderPosition = 0;

  final Paint fillPainter;
  final Paint wavePainter;

  WavePainter({
    @required this.sliderPosition,
    @required this.dragPercentage,
    @required this.color,
    @required this.animationProgress,
    @required this.sliderState,
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

    switch (sliderState) {
      case SliderState.starting:
        _paintStartingWave(canvas, size);
        break;
      case SliderState.sliding:
        _paintSlidingWave(canvas, size);
        break;
      case SliderState.stopping:
        _paintStoppingWave(canvas, size);
        break;
      case SliderState.resting:
      default:
        _paintRestingWave(canvas, size);
        break;
    }
  }

  void _paintStartingWave(Canvas canvas, Size size) {
    WaveCurveDefinitions line = _calculateWaveCurveDefinitions(size);

    double waveHeight = lerpDouble(
      size.height,
      line.controlHeight,
      Curves.elasticOut.transform(animationProgress),
    );

    line.controlHeight = waveHeight;

    _paintWaveLine(canvas, size, line);
  }

  void _paintRestingWave(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  void _paintSlidingWave(Canvas canvas, Size size) {
    WaveCurveDefinitions waveCurve = _calculateWaveCurveDefinitions(size);
    _paintWaveLine(canvas, size, waveCurve);
  }

  void _paintStoppingWave(Canvas canvas, Size size) {
    WaveCurveDefinitions line = _calculateWaveCurveDefinitions(size);

    double waveHeight = lerpDouble(
      line.controlHeight,
      size.height,
      Curves.elasticOut.transform(animationProgress),
    );

    line.controlHeight = waveHeight;

    _paintWaveLine(canvas, size, line);
  }

  void _paintAnchors(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0, size.height), 5, fillPainter);
    canvas.drawCircle(Offset(size.width, size.height), 5, fillPainter);
  }

  WaveCurveDefinitions _calculateWaveCurveDefinitions(Size size) {
    double minWaveHeight = 0.2 * size.height;
    double maxWaveHeight = 0.8 * size.height;

    double controlHeight =
        (size.height - minWaveHeight) - (maxWaveHeight * dragPercentage);

    double bendWidth = 20 + 20 * dragPercentage;
    double bezierWidth = 20 + 20 * dragPercentage;

    double centerPoint = sliderPosition;
    centerPoint = (centerPoint > size.width) ? size.width : centerPoint;

    double startOfBend = sliderPosition - bendWidth / 2;
    double endOfBend = sliderPosition + bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBezier = endOfBend + bezierWidth;

    startOfBend = (startOfBend <= 0) ? 0 : startOfBend;
    startOfBezier = (startOfBezier <= 0) ? 0 : startOfBezier;
    endOfBend = (endOfBend >= size.width) ? size.width : endOfBend;
    endOfBezier = (endOfBezier >= size.width) ? size.width : endOfBezier;

    double leftControlPoint1 = startOfBend;
    double leftControlPoint2 = startOfBend;
    double rightControlPoint1 = endOfBend;
    double rightControlPoint2 = endOfBend;

    double bendability = 25;
    double maxSlideDifference = 30;

    double slideDifference = (sliderPosition - _previousSliderPosition).abs();
    if (slideDifference > maxSlideDifference) {
      slideDifference = maxSlideDifference;
    }

    bool moveLeft = sliderPosition < _previousSliderPosition;

    double bend =
        lerpDouble(0, bendability, slideDifference / maxSlideDifference);

    bend = moveLeft ? -bend : bend;

    leftControlPoint1 += bend;
    leftControlPoint2 -= bend;
    rightControlPoint1 -= bend;
    rightControlPoint2 += bend;
    centerPoint -= bend;

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

  void _paintWaveLine(
    Canvas canvas,
    Size size,
    WaveCurveDefinitions waveCurve,
  ) {
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
  final double centerPoint;
  double controlHeight;

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

class WaveSliderController extends ChangeNotifier {
  final AnimationController controller;
  SliderState _state = SliderState.resting;

  WaveSliderController({@required TickerProvider vsync})
      : controller = AnimationController(vsync: vsync) {
    controller
      ..addListener(_onProgressUpdate)
      ..addStatusListener(_onStatusUpdate);
  }

  double get progress => controller.value;

  SliderState get state => _state;

  void _onProgressUpdate() {
    notifyListeners();
  }

  void _onStatusUpdate(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _onTransitionCompleted();
    }
  }

  void _onTransitionCompleted() {
    if (_state == SliderState.stopping) {
      setStateToResting();
    }
  }

  void _startAnimation() {
    controller.duration = Duration(milliseconds: 500);
    controller.forward(from: 0);
    notifyListeners();
  }

  void setStateToResting() {
    _state = SliderState.resting;
  }

  void setStateToStarting() {
    _startAnimation();
    _state = SliderState.starting;
  }

  void setStateToStopping() {
    _startAnimation();
    _state = SliderState.stopping;
  }

  void setStateToSliding() {
    _state = SliderState.sliding;
  }
}

enum SliderState {
  starting,
  resting,
  sliding,
  stopping,
}
