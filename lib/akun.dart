import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/main.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'dart:convert';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  FlutterSecureStorage storage;
  String _valueLogin = '';
  String noUser = '';
  var foto = '';
  var nama = "";

  void initState() {
    super.initState();
    storage = FlutterSecureStorage();

    read();
  }

  void read() async {
    _valueLogin = await storage.read(key: "login");
    var namax = await storage.read(key: "nama");
    var akun = await storage.read(key: "user");
    var userJson = jsonDecode(akun);
    var _noUserJson = jsonDecode(_valueLogin);
    var d = userJson['foto'].replaceRange(0, 2, 'https://siptom.net');
    setState(() {
      noUser = _noUserJson['no_user'];
      nama = namax;
      foto = d;
    });
  }

  void logout() async {
    storage.deleteAll();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SplashScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe6edf4),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Image.asset(
          "images/svg/logo_header.png",
          alignment: Alignment.centerLeft,
          width: 160,
        ),
        centerTitle: false,
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [defaultShadow],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(foto),
                            backgroundColor: mainColor,
                            radius: 40.0,
                          ),
                        ),
                        Text(
                          nama,
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noUser,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //   left: MediaQuery.of(context).size.width / 5,
                  //   right: MediaQuery.of(context).size.width / 5,
                  //   bottom: 10,
                  //   top: 10,
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     child: CircleAvatar(
                  //       backgroundColor: mainColor,
                  //       radius: 100.0,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/UbahPass');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(
                        FontAwesome5.key,
                        color: mainColor,
                        size: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        ' Ubah Password',
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black54.withOpacity(0.15),
              height: 0,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/KebijakanPrivasiPage');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(
                        FontAwesome5.lock,
                        color: mainColor,
                        size: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        ' Kebijakan Privasi',
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black54.withOpacity(0.15),
              height: 0,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/TentangKamiPage');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(
                        FontAwesome5.users_cog,
                        color: mainColor,
                        size: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        ' Tentang Kami',
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black54.withOpacity(0.15),
              height: 0,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/FAQPage');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(
                        FontAwesome5.question,
                        color: mainColor,
                        size: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        ' FAQ',
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black54.withOpacity(0.15),
              height: 0,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(
                onPressed: () {
                  logout();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(
                        FontAwesome5.sign_out_alt,
                        color: mainColor,
                        size: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        ' Keluar',
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black54.withOpacity(0.15),
              height: 0,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(
              height: 90,
            )
          ],
        ),
      ),
    );
  }
}
