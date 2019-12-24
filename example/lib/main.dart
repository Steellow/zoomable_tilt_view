import 'package:flutter/material.dart';
import 'package:zoomable_tilt_view/zoomable_tilt_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZoomableTiltView Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("zoomable_tilt_view"),
      ),
      body: Center(
        child: ZoomableTiltView(
          yTiltLimit: 50,
          xTiltLimit: 50,
          tiltSensitivity: 1.5,
          zoomLimit: 1.8,
          child: Container(
            height: 200,
            width: 200,
            child: Card(
              color: Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 10,
              child: Center(
                child: Text(
                  "HIREME",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
