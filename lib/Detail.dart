import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/HomePage.dart';
import 'package:my_app/constant.dart';
import 'package:my_app/log.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DetailTools extends StatefulWidget {
  final String kode_tools;
  DetailTools(this.kode_tools);

  @override
  _DetailToolsState createState() => _DetailToolsState();
}

class _DetailToolsState extends State<DetailTools> {
  FlutterSecureStorage storage;
  String value_login = '';
  String no_user = '';
  String login = '';
  var stok;
  int _n = 0;
  Tools tools;
  bool _isButtonDisabled;

  Future<Tools> getTools() async {
    await http
        .get(
            "http://473d6492f6f7.ngrok.io/pintools_app_php/search.php?code=${widget.kode_tools}")
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          tools = Tools.fromJson(jsonDecode(response.body));
          var string_stok = tools.stok_akhir;
          stok = int.parse(string_stok);
          if (stok < 1) {
            _isButtonDisabled = true;
          }
          print(tools.stok_akhir);
        });
      }
    });
    return tools;
  }

  Text txt = Text("0");
  String post_pinjam;
  Peminjaman pinjamx;
  Future<Peminjaman> pinjam() async {
    print(_n);
    await http.post("${link}/pinjam.php", body: {
      "noUser": no_user,
      "id_tools": tools.id_tools,
      "jml_pinjam": _n.toString(),
      "stok_akhir": tools.stok_akhir,
      "kondisi_pinjam": tools.desk_tools,
    }).then((response) {
      int length = jsonDecode(response.body).length;
      // while (length > 0) {
      //   pinjamx = Peminjaman.fromJson(jsonDecode(response.body));
      //   length--;
      // }

      if (response != null) {
        String json_response = jsonDecode(response.body).toString();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => LogPeminjaman(Data: json_response)));
        print(jsonDecode(response.body));
      }
    }).catchError((error) {});
    return pinjamx;
  }

  void initState() {
    _isButtonDisabled = false;

    getTools();
    super.initState();
    storage = FlutterSecureStorage();
    read();
  }

  void add() {
    setState(() {
      if (_n < stok) _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  void read() async {
    var stopwatch = new Stopwatch()..start();

    //read from the secure storage
    value_login = await storage.read(key: "login");

    var json_value_login = jsonDecode(value_login);
    var nim = json_value_login["nim"];

    setState(() {
      no_user = nim;
      login = json_value_login.toString();
    });
  }

  Future kembali() {
    log(login);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => HomePage(NO_user: login)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tools == null
            ? Text("blabla")
            : Stack(children: <Widget>[
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
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width -
                                      MediaQuery.of(context).size.width / 8,
                                  height: MediaQuery.of(context).size.width -
                                      MediaQuery.of(context).size.width / 8,
                                  color: Colors.black12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Image(
                                      image: NetworkImage(
                                          "${link}/img/${tools.image_tools}"),
                                      //ambil link dr db

                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      Icons.home,
                                      color: Colors.blueGrey,
                                      size: MediaQuery.of(context).size.height /
                                          42,
                                    ),
                                    Text(
                                      "   ${tools.lokasi_tools}",
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
                                    "${tools.nama_tools}".toUpperCase(),
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
                                    "${tools.thn_masuk}",
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
                                    "${tools.stok_akhir} / ${tools.stok_awal}",
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
                                  "${tools.bahan}",
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
                              Text(
                                "${tools.merk}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15,
                                width: 0,
                              ),
                              Text(
                                "${tools.type}",
                                style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: mainColor),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black54,
                            height: 0,
                            thickness: 0.5,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    minus();
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  color: mainColor,
                                  padding: EdgeInsets.all(10.0),
                                  shape: CircleBorder(),
                                ),
                                Container(
                                    color: Colors.black12,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                    child: Text('$_n')),
                                FlatButton(
                                  onPressed: () {
                                    add();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  color: mainColor,
                                  padding: EdgeInsets.all(10.0),
                                  shape: CircleBorder(),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: new EdgeInsets.only(top: 12),
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 8,
                                child: RaisedButton(
                                  onPressed: _isButtonDisabled ? null : pinjam,
                                  disabledColor: Colors.black12,
                                  elevation: 5.0,
                                  disabledTextColor: Colors.black26,
                                  padding:
                                      new EdgeInsets.symmetric(vertical: 15),
                                  color: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  textColor: mainColor2,
                                  child: Text(
                                    "Pinjam",
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                35),
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
                                      onPressed: () {
                                        kembali();
                                      },
                                      color: Colors.black12,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding: new EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: mainColor,
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
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
