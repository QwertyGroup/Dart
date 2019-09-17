import 'package:cookbook/src/cf_identity.dart';
import 'package:cookbook/src/pageswipe.dart';
import 'package:cookbook/src/staggered.dart';
import 'package:cookbook/src/waveslider.dart';
import 'package:flutter/material.dart';

class BackdropPage extends StatefulWidget {
  @override
  _BackdropPageState createState() => _BackdropPageState();
}

class _BackdropPageState extends State<BackdropPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      value: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _triggerFling() {
    _controller.fling(velocity: isPanelVisible ? -1 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backdrop'),
        elevation: 0,
        actions: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Icon(Icons.add_shopping_cart),
          // ),
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller.view,
            ),
            onPressed: _triggerFling,
          ),
        ],
        // airplanemode_inactive
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(CFIdentity.fff_circs),
          // child: Icon(CFIdentity.cflogo_cell_negative),
        ),
      ),
      body: TwoPanels(
        controller: _controller,
        onTap: _triggerFling,
      ),
    );
  }
}

class TwoPanels extends StatefulWidget {
  final AnimationController controller;
  final VoidCallback onTap;
  TwoPanels({@required this.controller, @required this.onTap});

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const double headerHeight = 32;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - headerHeight;
    final frontPanelHeight = -headerHeight;
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, backPanelHeight, 0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.linear,
      ),
    );
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: theme.primaryColor,
            child: Center(
              child: Text(
                'Backpanel',
                style: theme.textTheme.title.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              color: theme.cardColor,
              elevation: 7,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.onTap,
                    onVerticalDragStart: (_) => widget.onTap(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: headerHeight,
                      child: Center(
                        child: Text(
                          'Drag',
                          style: theme.textTheme.button
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: LayoutBuilder(
                  //     builder: (context, constraints) {
                  //       return FittedBox(
                  //         fit: BoxFit.cover,
                  //         child: Container(
                  //           constraints: constraints,
                  //           // child: PageSwipe(),
                  //           child: WaveApp(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // Expanded(
                  //   child: FittedBox(
                  //     fit: BoxFit.cover,
                  //     child: Container(
                  //       constraints: constraints,
                  //       // child: PageSwipe(),
                  //       child: WaveApp(),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      constraints: constraints,
                      // child: PageSwipe(),
                      child: WaveApp(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}

// child: Center(
//   child: Text(
//     'Front',
//     style: theme.textTheme.display3,
//   ),
// ),
// flex: ,
// child: SizedBox(
//   width: 200,
//   height: 200,
//   child: FittedBox(
// fit: BoxFit.cover,
