import 'package:flutter/material.dart';
import 'package:my_app/constant.dart';
import 'model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DetailTools extends StatefulWidget {
  final String kode_tools;
  DetailTools(this.kode_tools);

  @override
  _DetailToolsState createState() => _DetailToolsState();
}

class _DetailToolsState extends State<DetailTools> {
  Future<Tools> getTools() async {
    await http.get("http://2a4bb0cb73d8.ngrok.io/pintools_app_php/login.php?");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              color: bgColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image(
                          image: NetworkImage(
                              "https://th.bing.com/th/id/OIP.lofKFNIFMYxS__pc1Me_EgHaFj?pid=Api&rs=1"),
                          //ambil link dr db
                          height: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 8,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.blueGrey,
                                size: MediaQuery.of(context).size.height / 42,
                              ),
                              Text(
                                "   Lab Telkom Timur-02",
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 1.5,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              widget.kode_tools.toUpperCase(),
                              textAlign: TextAlign.start,
                              //widget.kode_tools.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 24,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              "2014",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1.0,
                                  color: Colors.blueGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              "•",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blueGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              "2/4",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1.0,
                                  color: Colors.blueGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              "•",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blueGrey),
                            ),
                          ),
                          Text(
                            "Plastik",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1.0,
                                color: Colors.blueGrey),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: new EdgeInsets.only(top: 12),
                          child: Text(
                            "TP Link",
                            style: TextStyle(
                                fontSize: 18,
                                color: mainColor,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          "TL-MR3220",
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                              color: mainColor),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: new EdgeInsets.only(top: 12),
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 8,
                          child: RaisedButton(
                            onPressed: () {},
                            padding: new EdgeInsets.symmetric(vertical: 15),
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "Pinjam",
                              style: TextStyle(
                                  color: mainColor2,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 35),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width / 8,
                            margin: new EdgeInsets.only(top: 12),
                            child: FlatButton(
                                onPressed: () {},
                                color: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: new EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: mainColor,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              35),
                                )),
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
