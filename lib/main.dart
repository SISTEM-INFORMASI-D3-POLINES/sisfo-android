import 'dart:async';
import 'dart:convert';

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
import 'HomePage.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'forgotPass.dart';

const simplePeriodicTask = "simplePeriodicTask";
final storage = FlutterSecureStorage();
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();

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
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 1), helloAlarmID, callbackDispatcher);
}

void callbackDispatcher() async {
  FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
  var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iOS = IOSInitializationSettings();
  var initSetttings = InitializationSettings(android, iOS);
  flp.initialize(initSetttings);
  String noUser = '';
  var readLogin = await storage.read(key: "login");
  if (readLogin != null) {
    var _noUserJson = jsonDecode(readLogin);
    noUser = _noUserJson['no_user'];

    // Pinjam Setuju
    await http
        .get(link + '/msg/msgPinjamSetuju.php?noUser=' + noUser)
        .then((response) {
      print("here================");
      var convert = jsonDecode(response.body);
      print(convert['msg'].toString());
      if (response.statusCode == 200) {
        int i = 0;
        var msg = convert['msg'];
        while (i < msg.length) {
          var title = msg[i]['title'];
          var body = msg[i]['body'];
          int x = int.parse('00$i');
          showNotification(x, title, body, flp);
          i++;
        }
      } else {
        print("no messgae");
      }
    }).catchError((onError) {
      print("no message");
    });
    // pinjam reject
    await http
        .get(link + '/msg/msgPinjamReject.php?noUser=' + noUser)
        .then((response) {
      print("here================");
      var convert = jsonDecode(response.body);
      print(convert['msg'].toString());
      if (response.statusCode == 200) {
        int i = 0;
        var msg = convert['msg'];
        while (i < msg.length) {
          var title = msg[i]['title'];
          var body = msg[i]['body'];
          int x = int.parse('01$i');
          showNotification(x, title, body, flp);
          i++;
        }
      } else {
        print("no messgae");
      }
    }).catchError((onError) {
      print("no message");
    });
    // kembali setuju
    await http
        .get(link + '/msg/msgKembaliSetuju.php?noUser=' + noUser)
        .then((response) {
      print("here================");
      var convert = jsonDecode(response.body);
      print(convert['msg'].toString());
      if (response.statusCode == 200) {
        int i = 0;
        var msg = convert['msg'];
        while (i < msg.length) {
          var title = msg[i]['title'];
          var body = msg[i]['body'];
          int x = int.parse('02$i');
          showNotification(x, title, body, flp);
          i++;
        }
      } else {
        print("no messgae");
      }
    }).catchError((onError) {
      print("no message");
    });
    // kembali reject
    await http
        .get(link + '/msg/msgKembaliReject.php?noUser=' + noUser)
        .then((response) {
      print("here================");
      var convert = jsonDecode(response.body);
      print(convert['msg'].toString());
      if (response.statusCode == 200) {
        int i = 0;
        var msg = convert['msg'];
        while (i < msg.length) {
          var title = msg[i]['title'];
          var body = msg[i]['body'];
          int x = int.parse('03$i');
          showNotification(x, title, body, flp);
          i++;
        }
      } else {
        print("no messgae");
      }
    }).catchError((onError) {
      print("no message");
    });
    // reminder
    await http
        .get(link + '/msg/msgReminder.php?noUser=' + noUser)
        .then((response) {
      print("here================");
      var convert = jsonDecode(response.body);
      print(convert['msg'].toString());
      if (response.statusCode == 200) {
        int i = 0;
        var msg = convert['msg'];
        while (i < msg.length) {
          var title = msg[i]['title'];
          var body = msg[i]['body'];
          int x = int.parse('04$i');
          showNotification(x, title, body, flp);
          i++;
        }
      } else {
        print("no messgae");
      }
    }).catchError((onError) {
      print("no message");
    });
  }

  return Future.value(true);
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final storage = FlutterSecureStorage();
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
    var _valueUser = await storage.read(key: "user");

    setState(() {
      noUser = value_login;
      nama = value_nama;
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
