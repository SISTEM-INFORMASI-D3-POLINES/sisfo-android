import 'package:flutter/material.dart';
import 'package:my_app/HomePage.dart';
import 'package:my_app/cari.dart';
import 'package:my_app/forgotPass.dart';
import 'package:my_app/kembali.dart';
import 'package:my_app/log.dart';
import 'package:my_app/login_page.dart';
import 'package:my_app/main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());
    case '/LoginPage':
      return MaterialPageRoute(builder: (_) => LoginPage());
    case '/ForgotPassPage':
      return MaterialPageRoute(builder: (_) => ForgotPass());
    case '/LogPage':
      return MaterialPageRoute(builder: (_) => LogPeminjaman());
    case '/CariPage':
      return MaterialPageRoute(builder: (_) => CariPage());
    case '/KembaliPage':
      return MaterialPageRoute(builder: (_) => KembaliPage());
    default:
      return MaterialPageRoute(builder: (_) => SplashScreen());
  }
}
