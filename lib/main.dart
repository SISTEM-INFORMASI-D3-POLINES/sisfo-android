import 'package:flutter/material.dart';
import 'package:my_app/login_page.dart';
import 'HomePage.dart';
import 'forgotPass.dart';

String no_user = '';

void main() => runApp(MaterialApp(
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) => new HomePage(NO_user: no_user),
        '/ForgotPassPage': (BuildContext context) => new ForgotPass(),

        // '/CariPage': (BuildContext context) => new CariPage(
        //       username: username,
        //     ),
        // '/PinjamPage': (BuildContext context) =>
        //     new PinjamPage(username: username),
        // '/KembaliPage': (BuildContext context) =>
        //     new PinjamPage(username: username),
        // '/LogPage': (BuildContext context) =>
        //     new PinjamPage(username: username),
        // '/AkunPage': (BuildContext context) =>
        //     new PinjamPage(username: username),
      },
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}
