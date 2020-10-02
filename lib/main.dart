import 'dart:async';
import 'dart:convert';
import 'dart:developer';

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
import 'package:http/http.dart' as http;
import 'package:my_app/ubah_password.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'HomePage.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
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
      '/UbahPassConfirm': (context) => UbahPassConfirm()
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
  FirebaseMessaging fm = FirebaseMessaging();
  // constructor

  final storage = FlutterSecureStorage();
  Widget page = LoginPage();
  AnimationController _controller;
  String _valueLogin = '';
  String _valueNama = '';
  String noUser = '';
  String user = '';
  var no = '';
  var nama = "";

  _SplashScreenState() {
    var no_user = '';
    storage.read(key: "login").then((value) {
      var jsonLogin = jsonDecode(value);
      log(jsonLogin['no_user'].toString());
      fm.getToken().then((value) {
        http.post(link + "/saveToken.php",
            body: {"noUser": jsonLogin['no_user'], "token": value});
      });
    });
    fm.configure();
  }
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
    _valueLogin = await storage.read(key: "login");
    _valueNama = await storage.read(key: "nama");
    var _valueUser = await storage.read(key: "user");
    var json_login = jsonDecode(_valueLogin);

    setState(() {
      no = json_login['no_user'];
      noUser = _valueLogin;
      nama = _valueNama;
      user = _valueUser;
    });
  }

  startSplashScreen() async {
    print(noUser);
    read();
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (noUser == null && nama == null && user == null) {
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
