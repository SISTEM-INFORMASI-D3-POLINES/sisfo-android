import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/constant.dart';
import 'package:my_app/log.dart';
import 'package:my_app/login_page.dart';
import 'HomePage.dart';
import 'auth_service.dart';
import 'forgotPass.dart';

void main() async {
  // Run app!
  runApp(new MaterialApp(
    title: 'Pintools',
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomePage': (BuildContext context) => new HomePage(),
      '/LoginPage': (BuildContext context) => new LoginPage(),
      '/ForgotPassPage': (BuildContext context) => new ForgotPass(),
      '/LogPage': (BuildContext context) => new LogPeminjaman(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  FlutterSecureStorage storage;
  String no_user = '';
  Widget page = LoginPage();
  AnimationController _controller;
  String value_login = '';
  String noUser = '';
  var nama = "";
  @override
  void initState() {
    super.initState();
    read();
    startSplashScreen();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void read() async {
    var stopwatch = new Stopwatch()..start();
    value_login = await storage.read(key: "login");
    setState(() {
      noUser = value_login;
    });
  }

  startSplashScreen() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (noUser != null) {
      Navigator.of(context).pushReplacementNamed('/HomePage');
    } else {
      Navigator.of(context).pushReplacementNamed('/LoginPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: Image.asset("images/svg/logo_circle.png",
              width: 200.0, height: 200.0)),
    );
  }
}
