import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'dart:convert';
import 'HomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FlutterSecureStorage storage;
  var _value_login = '';
  var _value_nama = '';
  var _noUser = '';
  var _nama = '';
  void initState() {
    super.initState();
    storage = FlutterSecureStorage();
    read();
  }

  void _encrypt(key, nouser_enc) async {
    //write to the secure storage
    await storage.write(key: key, value: nouser_enc);
  }

  void read() async {
    _value_login = await storage.read(key: "login");
    _value_nama = await storage.read(key: "nama");
    var _value_user = await storage.read(key: "user");

    _noUser = _value_login;
    _nama = _value_nama;

    setState(() {
      _noUser = _value_login;
      _nama = _value_nama;
    });

    if (_noUser != null && _nama != null && _value_user != null) {
      Navigator.of(context).pushReplacementNamed('/MainPage');
    }
  }

  List NO_user = [];
  var NO_user1 = '';
  String nama_tools;
  String getnama_tools;

  final noUser = TextEditingController();
  String msg = '';
  final pass = TextEditingController();
  var isSecure = true;
  Widget _buildLogo() {
    final String imageAsset = 'images/svg/logo_header.png';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            margin: const EdgeInsets.only(top: 30),
            child: Image(
              image: AssetImage(imageAsset),
              width: MediaQuery.of(context).size.width / 2,
            ))
      ],
    );
  }

  Widget _buildfooter() {
    return new Positioned(
        child: new Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "2020 © Pintools. " + "\n" + "Politeknik Negeri Semarang",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1.1,
                        fontSize: MediaQuery.of(context).size.height / 57),
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    Future<List> getLogin() async {
      String no_User = noUser.text;
      String passW = pass.text;

      await http.post("${link}/login.php", body: {
        "noUser": no_User,
        "pass": passW,
      }).then((response) {
        var datauser = json.decode(response.body);
        var success = datauser['success'];
        var login = datauser['login'][1];
        var jsonuser = json.decode(login);

        var nama = jsonuser['nama'];
        var datalogin = datauser['login'][0];

        setState(() {
          NO_user.add(login);
        });

        if (json.decode(success) == 1) {
          // await FlutterSession().set('datauser', datauser);
          _encrypt("login", datalogin.toString());
          _encrypt("nama", nama);
          _encrypt("user", login);
          Navigator.of(context).pushReplacementNamed('/MainPage');

          return datauser['login'];
        } else {
          setState(() {
            msg = "NIM/NIP atau password salah";
          });
        }
        setState(() {
          NO_user1 = no_User;
        });
      }).catchError((error) {
        setState(() {
          msg = "Akun tidak ditemukan";
        });
      });
      // var datauser = json.decode(response.body);

      // var loginx = login['nama'];
    }

    Widget _buildEmailRow() {
      return Padding(
        padding: EdgeInsets.only(top: 5, right: 8, left: 8),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: noUser,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: mainColor,
              ),
              labelText: "NIM/ NIP"),
          onChanged: (value) => noUser,
        ),
      );
    }

    Widget _buildPassRow() {
      return Padding(
        padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: pass,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: mainColor,
              ),
              labelText: "Password"),
        ),
      );
    }

    Widget _buildLoginButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 6.5 * (MediaQuery.of(context).size.width / 10),
            margin: EdgeInsets.only(bottom: 50, top: 20),
            child: RaisedButton(
              // elevation: 5.0,
              color: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: () {
                getLogin();
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: mainColor2,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height / 35),
              ),
            ),
          )
        ],
      );
    }

    Widget _buildForgetPasswordButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/ForgotPassPage');
            },
            child: Text("Lupa Password"),
          ),
        ],
      );
    }

    Widget _buildContainer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text("Login",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 30,
                                fontWeight: FontWeight.w600,
                                color: mainColor)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                          msg,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 57,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  _buildEmailRow(),
                  _buildPassRow(),
                  _buildForgetPasswordButton(),
                  _buildLoginButton()
                ],
              ),
            ),
          )
        ],
      );
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffe6edf4),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(90),
                  bottomRight: const Radius.circular(90),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Overlay(),
              _buildfooter(),
            ],
          )
        ],
      ),
    ));
  }
}
