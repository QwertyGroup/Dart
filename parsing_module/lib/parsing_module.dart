import 'dart:convert';
import 'dart:io';

import 'package:webdriver/io.dart';

class ParsingModule {
  WebDriver _driver;
  Process _process;

  Future<WebDriver> getDriver() async {
    print(Directory.current);
    _process = await Process.start(
        'chromedriver.exe', ['--port=4444', '--url-base=wd/hub']);

    await for (String browserOut
        in const LineSplitter().bind(utf8.decoder.bind(_process.stdout))) {
      print(browserOut);
      if (browserOut.contains('Starting ChromeDriver')) {
        break;
      }
    }

    _driver = await createDriver(
        uri: Uri.parse('http://localhost:4444/wd/hub/'),
        desired: Capabilities.chrome);

    print('driver returned');
    return _driver;
  }

  exit() async {
    await _driver.quit();
    _process.kill();
  }
}
