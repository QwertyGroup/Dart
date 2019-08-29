import 'dart:math';

import 'package:exploring/exploring.dart' as exploring;
import 'package:exploring/styling.dart' as my_slyling;
import 'package:exploring/styling.dart';

main(List<String> arguments) {
  print('Hello world: ${exploring.calculate()}!');
  var ex = 5;
  print('My test: $ex');
  printInt(123);
  // My very special number
  var newNumber = 1 << 10; // bit shift
  printInt(newNumber); // void function returns null

  print(my_slyling.main());
  print(sqrt(4));

  print(testOrsen());
}

printInt(int n) {
  print('You number: $n');
}

bool testOrsen() {
  try {
    var orsen = Orsen(12);
    return orsen.age == 20;
  } on Exception {
    return false;
  }
}
