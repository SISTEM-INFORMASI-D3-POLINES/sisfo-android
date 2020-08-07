import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String SECURE_NOTE_KEY = "SECURE_NOTE_KEY";

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Secure Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Example(
        title: "Flutter Secure Storage",
      ),
    );
  }
}

class Example extends StatefulWidget {
  Example({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  FlutterSecureStorage storage;

  String _encryptionTime;
  String _decryptionTime;

  String _sampleToken =
      "bqLSrt16%sE&P#nDi7ij4mjMRvUy9I9p0DtQn7crgf^BV21kJ6mu6NwE7ZESdOBDOdt1w%q6kAYsAHymtkXoDRr!zz0OA7#vxqOx";

  @override
  void initState() {
    super.initState();
    storage = FlutterSecureStorage();
  }

  @override
  void dispose() {
    super.dispose();
    storage = null;
  }

  void _encrypt() async {
    var stopwatch = new Stopwatch()..start();

    //write to the secure storage
    await storage.write(key: SECURE_NOTE_KEY, value: _sampleToken);

    print('Encrypting and saving executed in ${stopwatch.elapsed}');
    print(
        'Encrypting and saving executed in (mili) ${stopwatch.elapsedMilliseconds}');

    Fluttertoast.showToast(msg: "Token succesfully stored and encrypted!");
  }

  void _decrypt() async {
    var stopwatch = new Stopwatch()..start();

    //read from the secure storage
    String value = await storage.read(key: SECURE_NOTE_KEY);

    print('Decrypting and reading executed in ${stopwatch.elapsed}');
    print(
        'Decrypting and reading executed in ${stopwatch.elapsedMilliseconds}');
    log(value);

    Fluttertoast.showToast(msg: "Decrypted Token is:\n$value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: SelectableText("Token:\n\n$_sampleToken")),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Encrypt"),
                  onPressed: () {
                    _encrypt();
                  },
                ),
                SizedBox(
                  width: 32,
                ),
                RaisedButton(
                  child: Text("Decrypt"),
                  onPressed: () {
                    _decrypt();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
