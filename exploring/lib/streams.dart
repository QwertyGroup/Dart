import 'dart:async';

main() async {
  NumberCreator().stream.asBroadcastStream()
    ..take(15).where((x) => x % 2 == 0).map((x) => 'a$x').listen(print)
    ..take(5).map((x) => 'b$x').listen(print);

  await for (var i in NumberCreator().stream) {
    print('pri: $i');
  }
}

class NumberCreator {
  NumberCreator() {
    Timer.periodic(Duration(milliseconds: 500), (t) {
      _controller.sink.add(_count);
      _count++;
      if (_count > 12) {
        _controller.sink.close();
        t.cancel();
      }
    });
  }

  Stream<int> get stream => _controller.stream;
  final _controller = StreamController<int>();
  var _count = 1;
}
