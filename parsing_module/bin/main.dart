import 'dart:convert';
import 'dart:io';

import 'package:parsing_module/parsing_module.dart';

main(List<String> arguments) async {
  var module = ParsingModule();
  final driver = await module.getDriver();
  await driver.get('http://stackoverflow.com');

  print(await driver.execute('return navigator.userAgent', []));

  // Take a simple screenshot
  String screenshot = await driver.captureScreenshotAsBase64();
  File('stackoverflow.png').writeAsBytesSync(base64.decode(screenshot));

  module.exit();
  print('done');
}
