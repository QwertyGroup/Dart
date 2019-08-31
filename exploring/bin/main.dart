import 'dart:math';

import 'package:exploring/exploring.dart' as exploring;
import 'package:exploring/styling.dart' as my_styling;
import 'package:exploring/styling.dart';

const c1 = "Const one";
const c2 = "Const two";
const c3 = c1 + c2;
const concated = "hello" " world";
const a1 = [1, 2, 3];
final a2 = const [1, 2, 3];
var a3 = const [1, 2]; // const value
var a4 = [1, 2]; // non const value
const intLiteral = 123; // 123 is compile-time const

num n = 12; // 12 is an int literal, num is abstract class
int hex = 0xDEADBEEF;
var hex2 = 0xDEADBEEF;
var y = 1.1;
var exponents = 1.42e5;
double exponents2 = 1.42e5;
double z = 1; // Equivalent to double z = 1.0
String s = 'hello!'; // '...' is an String literal
String s2 = "hey'lo"; // "..." is an String literal too
bool flag = true; // true is bool literal
List<int> l = [1, 2]; // [] - list litral
List l2 = [1, 2]; // non generic list (i suppose)
Set se = {1, 2, 3}; // {, , ,} - set literal
var names = <String>{}; // uuu handy-dandy
// var names = {}; // Creates a map, not a set.
Map m = {'key': 'value'}; // {:,:,:} - map literal
Map<String, int> m2 = {'key': 12};
Map m3 = Map(); // or use ctor, but maybe not
var clapping = '\u{1f44f}'; // String, but rune
Runes input = Runes(
    '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}'); // runes
Symbol lib = Symbol("foo_lib"); // dont know what they are for
const myConst = "hello0";
const sy = #myConst;

// const string
const myc1 = 1;
const mya1 = [1, 2, 3];
const str1 = 'c1=$myc1';
// const str2 = 'c2=$mya1'; // const list cant be in const string, but string - can cause it is immutable
// BUT
var constantList = const [1, 2, 3];
// constantList[1] = 1; // Uncommenting this causes an error.
// and now it's no longer clear for me
// const sss = 'as${(const [1, 2, 3])[0]}';

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
}

class Point {
  // implicit getter and setter method generated
  num x; // Declare instance variable x, initially null.
  num y; // Declare y, initially null.
  // only implicit getter
  final num z = 0; // Declare z, initially 0.

  // getter and setter in action
  num get lenSq => x * x + y * y + z * z;
  set lenSq(num value) => {}; // Dont give af what to do with this example

  Point.shittyWay(num x, num y) {
    // There's a better way to do this, stay tuned.
    this.x = x;
    this.y = y;
  }

  // Syntactic sugar for setting x and y
  // before the constructor body runs.
  Point(this.x, this.y); // default ctor. Only one can be defined
  // Good way

  // initializer list
  // superclass’s no-arg constructor
  // main class’s no-arg constructor

  Point.callSuper(num x, num y)
      : x = x, // Initializer list
        y = y,
        super(); // call super

  Point.fromJson(String json) {
    // parse json ...
  }

  // Also works. Just test
  Point.fromJson2(String json, this.x, this.y) {
    // parse json ...
  }

  // Named constructor
  Point.origin() {
    x = 0;
    y = 0;
  }
}

class OutOfLlamasException {}

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

takesFunc(Function func) {
  return func;
}

// control flow to collections
collectionIf() {
  var promoActive = true;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  assert(nav.length == 4);
}

collectionFor() {
  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');
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

printInt(int n) {
  print('You number: $n');
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

bitStuff() {
  assert((3 << 1) == 6); // 0011 << 1 == 0110
  assert((3 >> 1) == 1); // 0011 >> 1 == 0001
  assert((3 | 4) == 7); // 0011 | 0100 == 0111
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

bool testOrsen() {
  try {
    var orsen = Orsen(12);
    return orsen.age == 20;
  } on Exception {
    return false;
  }
}
