import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/bottomNav.dart';
import 'package:my_app/cari.dart';
import 'package:my_app/constant.dart';
import 'package:my_app/faq.dart';
import 'package:my_app/kebijakanprivasi.dart';
import 'package:my_app/kembali.dart';
import 'package:my_app/log.dart';
import 'package:my_app/login_page.dart';
import 'package:my_app/pinjam.dart';
import 'package:my_app/scan.dart';
import 'package:my_app/services/ubahPass_confirm.dart';
import 'package:my_app/tentangkami.dart';
import 'package:my_app/ubah_password.dart';
import 'HomePage.dart';
import 'auth_service.dart';
import 'forgotPass.dart';

void main() async {
  // Run app!
  runApp(new MaterialApp(
    title: 'Pintools',
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/MainPage': (BuildContext context) => new NavigationBottomBar(),
      '/HomePage': (BuildContext context) => new HomePage(),
      '/LoginPage': (BuildContext context) => new LoginPage(),
      '/ForgotPassPage': (BuildContext context) => new ForgotPass(),
      '/LogPage': (BuildContext context) => new LogPeminjaman(),
      '/CariPage': (BuildContext context) => new CariPage(),
      '/PinjamPage': (BuildContext context) => new PinjamPage(),
      '/KembaliPage': (BuildContext context) => new KembaliPage(),
      '/TentangKamiPage': (context) => TentangKami(),
      '/KebijakanPrivasiPage': (context) => KebijakanPrivasi(),
      '/FAQPage': (context) => FreqAQ(),
      '/UbahPass': (context) => UbahPassword(),
      '/ScanPage': (context) => ScanViewDemo(),
      '/UbahPassConfirm': (context) => UbahPassConfirm(),
    },
    theme: ThemeData(
      canvasColor: Colors.transparent,
      fontFamily: 'Open Sans',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
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
  String value_nama = '';
  String noUser = '';
  String user = '';
  var nama = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    read();
    startSplashScreen();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void read() async {
    value_login = await storage.read(key: "login");
    value_nama = await storage.read(key: "nama");
    var _value_user = await storage.read(key: "user");

    setState(() {
      noUser = value_login;
      nama = value_nama;
      user = _value_user;
    });
  }

  startSplashScreen() async {
    print(noUser);
    read();
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (noUser == '' && nama == '' && user == '') {
      Navigator.of(context).pushReplacementNamed('/LoginPage');
    } else {
      Navigator.of(context).pushReplacementNamed('/MainPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(noUser);
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: Image.asset("images/svg/logo_circle.png",
              width: 200.0, height: 200.0)),
    );
  }
}
