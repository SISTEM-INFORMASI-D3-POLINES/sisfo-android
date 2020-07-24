import 'package:flutter/material.dart';
import 'package:my_app/login_page.dart';
import 'HomePage.dart';

String username = '';

void main() => runApp(MaterialApp(
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) => new HomePage(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Cantik'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Image(
          image: NetworkImage(
              'https://th.bing.com/th/id/OIP.rPTfP-Gh6wAuSkcXzM3jbQHaFR?pid=Api&rs=1'),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
