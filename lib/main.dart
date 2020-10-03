import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

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

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
  var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iOS = IOSInitializationSettings();
  var initSetttings = InitializationSettings(android, iOS);
  flp.initialize(initSetttings);

  math.Random random = new math.Random();
  int randomNumber = random.nextInt(90);

  var date = DateTime.now();
  var dateString = date.second.toString() + date.millisecond.toString();
  int id = int.parse(dateString + randomNumber.toString());

  void showNotification(channel, title, v, flp) async {
    var android = AndroidNotificationDetails(
      'channel id',
      'channel NAME',
      'CHANNEL DESCRIPTION',
      priority: Priority.High,
      importance: Importance.Max,
      styleInformation: BigTextStyleInformation(''),
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    var iOS = iosNotificationDetails;
    var platform = NotificationDetails(android, iOS);
    await flp.show(channel, '$title', '$v', platform, payload: 'VIS \n $v');
  }

  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    showNotification(
        id, message['data']['title'], message['data']['title'], flp);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    showNotification(id, message['notification']['title'],
        message['notification']['title'], flp);
  }

  // Or do other work.
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
  void showNotification(channel, title, v, flp) async {
    var android = AndroidNotificationDetails(
      'channel id',
      'channel NAME',
      'CHANNEL DESCRIPTION',
      priority: Priority.High,
      importance: Importance.Max,
      styleInformation: BigTextStyleInformation(''),
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    var iOS = iosNotificationDetails;
    var platform = NotificationDetails(android, iOS);
    await flp.show(channel, '$title', '$v', platform, payload: 'VIS \n $v');
  }

  _SplashScreenState() {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);

    fm.configure(
        onMessage: (Map<String, dynamic> msg) async {
          // showNotification(msg['message_id'], "title", "body", flp);
          math.Random random = new math.Random();
          int randomNumber = random.nextInt(90);

          var date = DateTime.now();
          var dateString = date.second.toString() + date.millisecond.toString();
          int id = int.parse(dateString + randomNumber.toString());

          showNotification(id, msg['data']['title'], msg['data']['title'], flp);

          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  msg['data']['title'],
                  style:
                      TextStyle(color: mainColor, fontWeight: FontWeight.w600),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(msg['data']['body']),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'Ok',
                      style: TextStyle(
                          color: mainColor, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );

          print(msg);
        },
        onLaunch: (Map<String, dynamic> msg) async {
          math.Random random = new math.Random();
          int randomNumber = random.nextInt(90);

          var date = DateTime.now();
          var dateString = date.second.toString() + date.millisecond.toString();
          int id = int.parse(dateString + randomNumber.toString());

          showNotification(id, msg['data']['title'], msg['data']['title'], flp);
          print(msg);
        },
        onResume: (Map<String, dynamic> msg) async {
          math.Random random = new math.Random();
          int randomNumber = random.nextInt(99);

          var date = DateTime.now();
          var dateString = date.second.toString() + date.millisecond.toString();
          int id = int.parse(dateString + randomNumber.toString());

          showNotification(id, msg['data']['title'], msg['data']['title'], flp);
          // showNotification(msg['message_id'], "title", "body", flp);
          print(msg);
        },
        onBackgroundMessage: myBackgroundMessageHandler);
    storage.read(key: "login").then((value) {
      var jsonLogin = jsonDecode(value);
      fm.getToken().then((value) {
        http.post(link + "/saveToken.php",
            body: {"noUser": jsonLogin['no_user'], "token": value});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fm.requestNotificationPermissions();
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
