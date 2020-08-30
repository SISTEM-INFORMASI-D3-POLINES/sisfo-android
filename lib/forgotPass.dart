import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_page.dart';

class ForgotPass extends StatefulWidget {
  ForgotPass({Key key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
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
    Widget _buildLoginButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 6.5 * (MediaQuery.of(context).size.width / 10),
            margin: EdgeInsets.only(bottom: 50, top: 30),
            child: RaisedButton(
              elevation: 5.0,
              color: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => LoginPage()));
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

    Widget _buildContainer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: Row(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.75,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 18, left: 8),
                          child: Text("Lupa Password",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 43,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor)),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top: 23, left: 8),
                            child: Container(
                                child: new AutoSizeText.rich(
                                    TextSpan(
                                        text:
                                            'Silakan reset password Anda dengan menghubungi admin melalui email ',
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'admin@email.com',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  ' atau dengan mendatangi Unit Pelayanan Terpadu Teknologi Informasi dan Komunikasi Politeknik Negeri Semarang'),
                                        ]),
                                    minFontSize: 5,
                                    style: TextStyle(
                                        height:
                                            1.5, // the height between text, default is null
                                        letterSpacing:
                                            1.0 // the white space between letter, default is 0.0
                                        )))),
                      ],
                    ),
                    _buildLoginButton()
                  ],
                ),
              ),
            ]),
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
