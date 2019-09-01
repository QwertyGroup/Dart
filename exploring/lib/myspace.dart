main() {
  print('Hello from myspace');
  var b = B();
  var c = C();
  print(b.a);
  print(c.a);
  var list = <A>[];
  list.add(b);
  list.add(c);
  for (var i in list) {
    print(i.a);
    // print(i.yo);
  }
  var yoList = list.cast<Yo>();
  for (var i in yoList) {
    print(i.yo);
  }

  var mxOne = mixinOne();
  // var mxTwo = mixinTwo(); // cant
  print(mxOne);

  print('${c.extOne}, ${c.extTwo}');
  print(mixinTwo.initialCapacity);
  // print(C.intialCapaicty); // Nope
  mixinOne.SayMixin();
  print(Yo.yo2);
}

abstract class A {
  final a = 1;
}

abstract class Yo {
  static const yo2 = 0xFF;
  final yo = 0xFF;
}

class B implements A, Yo {
  final a = 2;
  final yo = 5;
}

class C extends A with mixinOne, mixinTwo implements Yo {
  final a = 3;
  final yo = 7;

  T first<T>(List<T> ts) {
    // Do some initial work or error checking, then...
    T tmp = ts[0];
    // Do some additional checking or processing...
    return tmp;
  }
}

// "on A" must be replaced with "extends"
class mixinOne {
  final extOne = 123;
  static SayMixin() {
    print(#mixinOne);
  }
}

mixin mixinTwo on A {
  static const initialCapacity = 16;
  final extTwo = 456;
}

abstract class SomeBaseClass {}

class Foo<T extends SomeBaseClass> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {}

// extra comma formats in column. Currently in row
enum Days { Sun, Mon, Tue, Wed, Thu, Fri, Sat }

class D<T> {
  Future<T> first(List<T> ts) async {
    T tmp = ts[0];
    return tmp;
  }
}
