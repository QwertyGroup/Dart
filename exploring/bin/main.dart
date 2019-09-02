import 'dart:math';

import 'package:exploring/exploring.dart' as exploring;
import 'package:exploring/styling.dart' as my_styling;
import 'package:exploring/styling.dart';
import 'package:meta/meta.dart';
import 'package:exploring/myspace.dart' as myspace;
import 'package:exploring/futures.dart' as futures;
import 'package:exploring/streams.dart' as streams;

main(List<String> arguments) {
  print('Hello world: ${exploring.calculate()}!');
  var ex = 5;
  print('My test: $ex');
  printInt(123);
  // My very special number
  var newNumber = 1 << 10; // bit shift
  printInt(newNumber); // void function returns null

  print('sy is $sy');

  print(my_styling.main());
  print(sqrt(4));

  print(testOrsen());

  regularExpressions();
  searchInString();
  spreadOperator();
  collectionIf();
  collectionFor();

  takesFunc(() => print("Hello"))();
  takesFunc(() {
    print("Hello-2");
  })();
  takesFunc((x) => print(x))(12);
  takesFunc((x) => print(x))("String");
  takesFunc(print)(takesFunc((x) => x * x)(12));
  // takesFunc((x) => x * x)("String"); // Error

  assignmentOperators();
  loopClosures();
  forIn();

  print('=' * 20);

  Human musician = Musician(name: 'Orsen', instrument: 'Drums');
  musician.Say('Hello');

  useImmutablePoint();

  print("LOOOP");
  // var cont = AbstractContainer();// do not uncomment
  print("end");

  print('${'*' * 8} myspace ${'*' * 8}');
  myspace.main();
  print('${'*' * 8} futures ${'*' * 8}');
  futures.main();
  print('${'*' * 8} streams ${'*' * 8}');
  streams.main();
}

const a1 = [1, 2, 3];
const c1 = "Const one";
const c2 = "Const two";
const c3 = c1 + c2;
const concated = "hello" " world";
const intLiteral = 123; // const value
const mya1 = [1, 2, 3]; // non const value
const myc1 = 1; // 123 is compile-time const

const myConst = "hello0"; // 12 is an int literal, num is abstract class
const str1 = 'c1=$myc1';
const sy = #myConst;
final a2 = const [1, 2, 3];
var a3 = const [1, 2];
var a4 = [1, 2];
var clapping = '\u{1f44f}'; // Equivalent to double z = 1.0
var constantList = const [1, 2, 3]; // '...' is an String literal
var exponents = 1.42e5; // "..." is an String literal too
double exponents2 = 1.42e5; // true is bool literal
bool flag = true; // [] - list litral
int hex = 0xDEADBEEF; // non generic list (i suppose)
var hex2 = 0xDEADBEEF; // {, , ,} - set literal
Runes input = Runes(
    '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}'); // uuu handy-dandy
// var names = {}; // Creates a map, not a set.
List<int> l = [1, 2]; // {:,:,:} - map literal
List l2 = [1, 2];
Symbol lib = Symbol("foo_lib"); // or use ctor, but maybe not
Map m = {'key': 'value'}; // String, but rune
Map<String, int> m2 = {'key': 12}; // runes
Map m3 = Map(); // dont know what they are for
num n = 12;
var names = <String>{};

// const string
String s = 'hello!';
String s2 = "hey'lo";
Set se = {1, 2, 3};
// const str2 = 'c2=$mya1'; // const list cant be in const string, but string - can cause it is immutable
// BUT
var y = 1.1;
// constantList[1] = 1; // Uncommenting this causes an error.
// and now it's no longer clear for me
// const sss = 'as${(const [1, 2, 3])[0]}';

double z = 1;

assignmentOperators() {
  var value = 12;
  int b;
  // Assign value to a
  var a = value;
  // Assign value to b if b is null; otherwise, b stays the same
  b ??= a;
  assert(b == 12);
  b ??= 13;
  assert(b != 13);
  var i = 1;
  i <<= 3; // nothing too interesting, just bit shift(
  assert(i == 8);
  i >>= 2; // nothing too interesting, just bit shift(
  assert(i == 2);
  // =	–=	/=	%=	>>=	^= +=	*=	~/=	<<=	&=	|=
  // ~/ is int division
  // ^	XOR
  // ()	Function application Represents a function call
  // []	List access	Refers to the value at the specified index in the list
  // .	Member access	Refers to a property of an expression;
  // ?.	Conditional member access, but if null returns null
}

bitStuff() {
  assert((3 << 1) == 6); // 0011 << 1 == 0110
  assert((3 >> 1) == 1); // 0011 >> 1 == 0001
  assert((3 | 4) == 7); // 0011 | 0100 == 0111
}

// This class is declared abstract and thus
// can't be instantiated.
collectionFor() {
  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');
}

collectionIf() {
  var promoActive = true;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  assert(nav.length == 4);
}

ex() {
  var breedMoreLlamas = () => {throw OutOfLlamasException()};
  var buyMoreLlamas = () => {};

  // rethrow saves stack trace
  try {
    breedMoreLlamas();
  } on OutOfLlamasException {
    // A specific exception
    buyMoreLlamas();
  } on Exception catch (e) {
    // Anything else that is an exception
    print('Unknown exception: $e');
    rethrow;
  } catch (e, s) {
    // No specified type, handles all
    print('stack trace: $s');
    print('Something really unknown: $e');
  } finally {
    print('Cleaning');
  }
}

forIn() {
  var collection = [0, 1, 2];
  for (var x in collection) {
    print(x); // 0 1 2
  }
}

loopClosures() {
  var callbacks = [];
  for (var i = 0; i < 4; i++) {
    callbacks.add(() => print(i));
  }
  callbacks.forEach((c) => c());
}

multilineAndRaw() {
  var s1 = '''
You can create
multi-line strings like this one.
''';

  var s2 = """This is also a
multi-line string.""";
  var s = r'In a raw string, not even \n gets special treatment.';

  assert(s1 + s2 + s != null);
}

printInt(int n) {
  print('You number: $n');
}

regularExpressions() {
  // Here's a regular expression for one or more digits.
  var numbers = RegExp(r'\d+');

  var allCharacters = 'llamas live fifteen to twenty years';
  var someDigits = 'llamas live 15 to 20 years';

// contains() can use a regular expression.
  assert(!allCharacters.contains(numbers));
  assert(someDigits.contains(numbers));

// Replace every match with another string.
  var exedOut = someDigits.replaceAll(numbers, 'XX');
  assert(exedOut == 'llamas live XX to XX years');

// Also
  numbers = RegExp(r'\d+');
  someDigits = 'llamas live 15 to 20 years';

// Check whether the reg exp has a match in a string.
  assert(numbers.hasMatch(someDigits));

// Loop through all matches.
  for (var match in numbers.allMatches(someDigits)) {
    print(match.group(0)); // 15, then 20
  }
}

searchInString() {
  // see https://dart.dev/guides/libraries/library-tour#strings-and-regular-expressions
  // for more info

  // Check whether a string contains another string.
  assert('Never odd or even'.contains('odd'));

// Does a string start with another string?
  assert('Never odd or even'.startsWith('Never'));

// Does a string end with another string?
  assert('Never odd or even'.endsWith('even'));

// Find the location of a string inside a string.
  assert('Never odd or even'.indexOf('odd') == 6);
}

spreadOperator() {
  {
    // to make scope
    //spread operator (...)
    var list = [1, 2, 3];
    var list2 = [0, ...list];
    assert(list2.length == 4);
  }
  // and null-checking spread operator
  // null-aware spread operator (...?)
  var list;
  var list2 = [0, ...?list];
  assert(list2.length == 1);
  print("spread operator");
}

stringIntoNumbers() {
  // String -> int
  var one = int.parse('1');
  assert(one == 1);

// String -> double
  var onePointOne = double.parse('1.1');
  assert(onePointOne == 1.1);

// int -> String
  String oneAsString = 1.toString();
  assert(oneAsString == '1');

// double -> String
  String piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');
}

takesFunc(Function func) {
  return func;
}

bool testOrsen() {
  try {
    var orsen = Orsen(12);
    return orsen.age == 20;
  } on Exception {
    return false;
  }
}

useImmutablePoint() {
  var imPoint = const ImmutablePoint(1, 2);
  var imPoint2 = const ImmutablePoint(1, 2);
  var point = ImmutablePoint(1, 2);

  assert(imPoint == imPoint2);
  assert(imPoint != point);
}

// control flow to collections
abstract class AbstractContainer {
  // Define constructors, fields, methods...

  factory AbstractContainer() => DangerousContainer();
  void updateChildren(); // Abstract method.

}

abstract class AbstractPoint {
  final num x, y;
  final String hello;
  factory AbstractPoint.fact() => const ImmutablePoint(0, 0);
}

abstract class Animal {
  void Say(String s);
}

class DangerousContainer extends AbstractContainer {
  // Container() {
  //   var gelk = AbstractContainer();
  // }
  factory DangerousContainer() => AbstractContainer(); // loooooop
  @override
  void updateChildren() {
    // Todo: implement updateChildren
    // `TODO: gives warning
  }
}

class Human extends Animal {
  final String _name;
  String lastname = 'default';

  Human(this._name);

  get name => _name;

  @override
  void Say(String message) {
    print('Human: $message');
  }
}

class ImmutablePoint implements AbstractPoint {
  static final ImmutablePoint origin = const ImmutablePoint(0, 0);

  final num x, y;
  final String hello;

  const ImmutablePoint(this.x, this.y, {this.hello});
}

class Musician extends Human with Talanted {
  String instrument;
  Musician({@required String name, this.instrument})
      : assert(name != 'whatever'),
        super(name);

  @override
  void Say(String message) {
    talantLevel++;
    print('Musician: $message. My talant is $talantLevel');
  }
}

class OutOfLlamasException {}

class Point {
  // implicit getter and setter method generated
  num x; // Declare instance variable x, initially null.
  num y; // Declare y, initially null.
  // only implicit getter
  final num z = 0; // Declare z, initially 0.

  // getter and setter in action
  Point(this.x, this.y);
  Point.alongX(num x) : this(x, 0); // Dont give af what to do with this example

  Point.callSuper(num x, num y)
      : x = x, // Initializer list
        y = y,
        super();

  // Syntactic sugar for setting x and y
  // before the constructor body runs.
  Point.fromJson(String json) {
    // parse json ...
  } // default ctor. Only one can be defined
  // Good way

  // initializer list
  // superclass’s no-arg constructor
  // main class’s no-arg constructor

  Point.fromJson2(String json, this.x, this.y) {
    // parse json ...
  } // call super

  Point.origin() {
    x = 0;
    y = 0;
  }

  Point.shittyWay(num x, num y) {
    // There's a better way to do this, stay tuned.
    this.x = x;
    this.y = y;
  }

  // Point.fromJson(int n) {} // ctor overloading is not available

  // Also works. Just test
  num get lenSq => x * x + y * y + z * z;

  // Named constructor
  set lenSq(num value) => {};

  void DoStuff(String s) {}
  // void DoStuff(int n) {} // method overloading is not here too
}

mixin Talanted on Human {
  int talantLevel = 12;
}
