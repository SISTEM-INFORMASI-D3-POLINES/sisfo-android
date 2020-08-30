import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';

class UbahPassword extends StatefulWidget {
  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  var text = '';
  var msg = '';
  FlutterSecureStorage storage;
  String value_login = '';
  String noUser = '';

  void initState() {
    super.initState();
    storage = FlutterSecureStorage();

    read();
  }

  void read() async {
    var stopwatch = new Stopwatch()..start();

    value_login = await storage.read(key: "login");
    var namax = await storage.read(key: "nama");
    var akun = await storage.read(key: "user");
    var userJson = jsonDecode(akun);
    var noUser_json = jsonDecode(value_login);
    setState(() {
      noUser = noUser_json['no_user'];
    });
  }

  void validate() async {
    await http.post("${link}/valid_pass.php",
        body: {"noUser": noUser, "pass": text}).then((response) {
      var respJson = jsonDecode(response.body);
      var success = respJson['success'];
      if (success == '1') {
        Navigator.pushNamed(context, '/UbahPassConfirm');
      } else {
        setState(() {
          msg = 'Password salah. Periksa kembali password Anda';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        iconTheme: IconThemeData(
          color: mainColor,
        ),
        title: Image.asset(
          "images/svg/logo_header.png",
          alignment: Alignment.centerLeft,
          width: 140,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Ubah Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: mainColor),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
              child: Text(
                'Masukkan password untuk verifikasi identitas bahwa Anda benar benar pemilik akun ini. Mengubah password, berarti mengubah password akun Anda pada situs siptom.net',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                style: TextStyle(fontSize: 14),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Masukkan password untuk lanjut';
                  }
                },
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: RaisedButton(
                  onPressed: () {
                    validate();
                  },
                  color: mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "Lanjut",
                    style: TextStyle(
                        color: mainColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
