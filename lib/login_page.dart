import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List NO_user = [];
  var NO_user1 = '';

  final noUser = TextEditingController();
  String msg = '';
  final pass = TextEditingController();
  var isSecure = true;
  Widget _buildLogo() {
    final String imageAsset = 'images/svg/logo_head_circle.svg';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: SvgPicture.asset(
            imageAsset,
            height: MediaQuery.of(context).size.height / 6,
          ),
        )
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

      final response = await http.post(
          "http://bf7f1702fc3c.ngrok.io/pintools_app_php/login.php",
          body: {
            "noUser": no_User,
            "pass": passW,
          });

      // var datauser = json.decode(response.body);
      var datauser = json.decode(response.body);
      var success = datauser['success'];
      var login = datauser['login'][1];
      NO_user.add(login);
      // var loginx = login['nama'];

      if (json.decode(success) == 1) {
        // await FlutterSession().set('datauser', datauser);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => HomePage(NO_user: login)));
        log(login.toString());
        return datauser['login'];
      } else {
        setState(() {
          msg = "NIM/NIP atau password salah";
        });
      }
      setState(() {
        NO_user1 = no_User;
      });
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
              elevation: 5.0,
              color: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                getLogin();
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: mainColor2,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
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
              height: MediaQuery.of(context).size.height * 0.55,
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
                        padding: const EdgeInsets.only(top: 18),
                        child: Text("Login",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 30,
                                fontWeight: FontWeight.bold,
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
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.68,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: mainColorAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(85),
                  bottomRight: const Radius.circular(85),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(90),
                  bottomRight: const Radius.circular(90),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              _buildContainer(),
            ],
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
