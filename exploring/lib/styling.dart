// // With snake_case
// library peg_parser.source_scanner;
// // It is fine to omit the library directive in a file
library styling.conventions; // dont really know what it does

import 'dart:math';

// import 'file_system.dart';
// import 'slider_menu.dart';

//import 'package:angular_components/angular_components' as angular_components;
// import 'package:js/js.dart' as js;

// Styling
class MySlider {
  static bool isOn = true;
  int makeRandom() => Random().nextInt(100);
}

main() {
  var mySlider = MySlider();
  print(mySlider.makeRandom());
}

// this is type definition
typedef Predicate<T> = bool Function(T value);

class Boo {
  const Boo([arg]); // what does it mean?
}

// this is metadata annotations
@Boo(123)
class A {}

@Boo()
class B {}

const boo = Boo();

@boo
class C {}

// consts
const pi = 3.14; // (Not) const PI = 3.14;
final urlScheme = RegExp('^([a-z]+):');

class Dice {
  static final numberGenerator = Random();
}

// insteaf of HTTPSFTP write HttpsFtp or HttpSftp (different meanings)
// more examples:
// HttpConnectionInfo
// uiHandler
// IOStream
// HttpRequest
// Id
// DB

class Hello {
  String _privateHello = "hello";
  String giveHello() => _privateHello;
}

const myName = 'Orsen';

class Orsen {
  final String name = myName;
  final int age;
  Orsen(this.age) : assert(age <= 20) {
    if (age != 20) throw Exception('Not twony');
  }
}
