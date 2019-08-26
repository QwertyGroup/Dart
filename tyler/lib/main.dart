import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

void main() => runApp(TylerApp());

class TylerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tyler',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        accentColor: Colors.amberAccent,
      ),
      home: MyHomePage(title: 'Tyler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      var counter = _counter << 2;
      _counter = counter == 0 ? 1 : counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: Icon(Icons.menu),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            child: Text(
              'You have pushed the button this many times:',
            ),
          ),
          Container(
            child: Text(
              '$_counter',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
          Container(
            child: MySlider(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class MyChart extends StatelessWidget {
//   final seriesList = createData(0.4);

//   @override
//   Widget build(BuildContext context) {
// return PieChart(
//   seriesList,
//   animate
// )  }
// }

class MySlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  var _value = 0.5;

  void _onValueChanged(double value) {
    setState(() => _value = value);
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      onChanged: _onValueChanged,
    );
  }
}
