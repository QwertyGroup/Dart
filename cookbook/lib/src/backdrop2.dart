import 'package:flutter/material.dart';
import 'dart:math';

class Backdrop2 extends StatefulWidget {
  final double headerHeight = 20;
  final bool headerVisible;
  final double flingVelocity = 1;
  final frontPanelOpenHeight = 700;

  Backdrop2({this.headerVisible = true});

  @override
  _Backdrop2State createState() => _Backdrop2State();
}

class _Backdrop2State extends State<Backdrop2>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final _backdropHeight = 900;

  bool get _backdropVisible =>
      _controller.status == AnimationStatus.completed ||
      _controller.status == AnimationStatus.forward;

  void _toggleBackdropPanelVisibility() => _controller.fling(
      velocity:
          _backdropVisible ? -widget.flingVelocity : widget.flingVelocity);

  void _handleDragUpdate(DragUpdateDetails details) {
    print('${details.delta}');
    if (!_controller.isAnimating) {
      _controller.value += details.primaryDelta / _backdropHeight;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;
    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: max(widget.flingVelocity, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: min(-widget.flingVelocity, -flingVelocity));
    else
      _controller.fling(
          velocity: _controller.value < 0.5
              ? -widget.flingVelocity
              : widget.flingVelocity);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      // 0 hides the panel; 1 shows the panel
      // value: (widget.panelVisible?.value ?? true) ? 1.0 : 0.0,
      value: 1,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size pageSize = constraints.biggest;
        final double closedRatio = widget.headerVisible
            ? (pageSize.height - widget.headerHeight) / pageSize.height
            : 1;
        // widget.frontPanelOpenHeight / pageSize.height;
        final double openRatio = 0;
        // final double openRatio = widget.frontPanelOpenHeight / pageSize.height;
        print('closedRatio: $closedRatio');
        print('openRatio: $openRatio');
        print('height: ${pageSize.height}');
        final panelPosition = Tween<Offset>(
          begin: Offset(0, closedRatio),
          end: Offset(0, openRatio),
        ).animate(_controller.view);

        return Stack(
          children: <Widget>[
            BackPlane(),
            SlideTransition(
              position: panelPosition,
              child: Material(
                elevation: 12.0,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                      onVerticalDragEnd: _handleDragEnd,
                      onVerticalDragUpdate: _handleDragUpdate,
                      child: Container(
                        alignment: Alignment.center,
                        height: widget.headerHeight,
                        child: Text('drag'),
                      ),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                    Expanded(
                      child: FrontPlane(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BackPlane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      child: Text(
        'BackPlane',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class FrontPlane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.brown,
      child: Text(
        'FrontPlane',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
