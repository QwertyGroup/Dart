import 'package:cli/cli.dart' as cli;
import 'package:cli/computePi.dart' as pi;

main(List<String> arguments) {
  print('Hello world: ${cli.calculate()}!');
  pi.main();
}
