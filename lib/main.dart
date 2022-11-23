import 'package:flutter/material.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:polygon/polygon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _insideArea = false;

  List<LatLng> _area = [
    LatLng(-28.725991254502993, 31.869631169395856),
    LatLng(-28.726362886400715, 31.86923432449268),
    LatLng(-28.727068512950524, 31.86997438660943),
    LatLng(-28.726819192113734, 31.870317603822997),
    LatLng(-28.726348773821147, 31.87001728876114),
  ];

  bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    return PolygonUtil.containsLocation(tap, vertices, false);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<bool> _checkIfInsideArea(LatLng tap) async {
    return _checkIfValidMarker(tap, _area);
  }

  @override
  initState() {
    super.initState();
    _insideArea = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'GeoJSON test',
            ),
            Text(
              '$_insideArea',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LatLng testValue = LatLng(-28.7263384, 31.8695439);
          // LatLng testValue = LatLng(-32.7263384, 33.8695439);
          _insideArea = await _checkIfInsideArea(testValue);
          setState(() {
            _insideArea = PolygonUtil.containsLocation(testValue, _area, true);
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
