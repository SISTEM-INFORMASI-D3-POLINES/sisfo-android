import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/bottomNav.dart';
import '../constant.dart';

class UbahPassConfirm extends StatefulWidget {
  @override
  _UbahPassConfirmState createState() => _UbahPassConfirmState();
}

class _UbahPassConfirmState extends State<UbahPassConfirm> {
  var passText1 = '';
  var passText2 = '';
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

  void change() async {
    if (passText1 != '' || passText2 != '') {
      if (passText2 == passText1) {
        await http.post("${link}/ubah_pass.php",
            body: {'noUser': noUser, 'pass': passText1}).then((response) {
          var respJson = jsonDecode(response.body);
          if (response.statusCode == 200) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationBottomBar(),
              ),
            );
          } else {
            setState(() {
              msg = 'Password salah. Periksa kembali password Anda';
            });
          }
        });
      } else {
        setState(() {
          msg = 'Password tidak sesuai. Silahkan periksa kembali';
        });
      }
    } else {
      setState(() {
        msg = 'Password tidak boleh kosong';
      });
    }
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
              Text(msg),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      passText1 = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password baru',
                  ),
                  style: TextStyle(fontSize: 14),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      passText2 = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Konfirmasi password',
                  ),
                  style: TextStyle(fontSize: 14),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      if (value != passText1) {
                        return 'Password tidak sesuai. Silahkan periksa kembali';
                      }
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
                      change();
                    },
                    color: mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      "Setel Password",
                      style: TextStyle(
                          color: mainColor2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
