import 'package:flutter/material.dart';
import 'package:my_app/login_page.dart';
import 'HomePage.dart';
import 'forgotPass.dart';

String no_user = '';

void main() {
  // Run app!
  runApp(new MaterialApp(
    title: 'Pintools',
    home: LoginPage(),
    routes: <String, WidgetBuilder>{
      '/HomePage': (BuildContext context) => new HomePage(NO_user: no_user),
      '/ForgotPassPage': (BuildContext context) => new ForgotPass(),
    },
  ));
}
