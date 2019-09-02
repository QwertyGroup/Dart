main() async {
  futures();
  runGenerators();
}

futures() {
  Future<int>.delayed(
    Duration(seconds: 2),
    () {
      return 123;
    },
  ).then((value) {
    print(value);
  });

  Future.value(222).then(print);
}

runGenerators() async {
  var gen = Gen();
  for (var i in gen()) {
    print(i);
  } // equivalent
  for (var i in gen.call()) {
    print(i);
  }

  print('#' * 3);
  for (var i in gen.naturalsTo(10)) {
    print(i);
  }

  print('#' * 3);
  await for (var i in gen.asynchronousNaturalsTo(4)) {
    print(i);
  }

  print('#' * 3);
  for (var i in gen.naturalsDownFrom(8)) {
    print(i);
  }
}

class Gen {
  call() => naturalsTo(2);

  Iterable<int> naturalsTo(int n) sync* {
    int k = 0;
    while (k < n) {
      yield k++;
    }
  }

  Stream<int> asynchronousNaturalsTo(int n) async* {
    int k = 0;
    while (k < n) {
      yield k++;
    }
  }

  Iterable<int> naturalsDownFrom(int n) sync* {
    if (n > 0) {
      yield n;
      yield* naturalsDownFrom(n - 1);
    }
  }
}
