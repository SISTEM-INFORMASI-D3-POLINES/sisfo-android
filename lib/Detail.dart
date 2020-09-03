import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/bottomNav.dart';
import 'package:my_app/constant.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DetailTools extends StatefulWidget {
  final String kodeTools;

  DetailTools(this.kodeTools);

  @override
  _DetailToolsState createState() => _DetailToolsState();
}

class _DetailToolsState extends State<DetailTools> {
  FlutterSecureStorage storage;
  String _valueLogin = '';
  String _noUser = '';
  String login = '';
  var stok;
  int _n = 0;
  Tools tools;
  bool _isButtonDisabled;

  Future<Tools> getTools() async {
    await http
        .get("${link}/search.php?code=${widget.kodeTools}")
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          tools = Tools.fromJson(jsonDecode(response.body));
          var stringStok = tools.stok_akhir;
          stok = int.parse(stringStok);
          if (stok < 1) {
            _isButtonDisabled = true;
          }
        });
      }
    });
    return tools;
  }

  Text txt = Text("0");
  String postPinjam;
  Peminjaman pinjamx;
  Future<Peminjaman> pinjam() async {
    await http.post("${link}/pinjam.php", body: {
      "noUser": _noUser,
      "id_tools": tools.id_tools,
      "jml_pinjam": _n.toString(),
      "stok_akhir": tools.stok_akhir,
      "kondisi_pinjam": tools.desk_tools,
    }).then((response) {
      if (response != null) {
        Navigator.pushReplacementNamed(context, '/MainPage');
      }
    }).catchError((error) {});
    return pinjamx;
  }

  void initState() {
    _isButtonDisabled = false;

    super.initState();
    storage = FlutterSecureStorage();
    getTools();
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
    _valueLogin = await storage.read(key: "login");
    var _valueUser = await storage.read(key: "nama");

    var _jsonValueLogin = jsonDecode(_valueLogin);
    var nim = _valueUser;

    setState(() {
      _noUser = _jsonValueLogin['no_user'];
      login = _jsonValueLogin.toString();
    });
  }

  Future kembali() {
    log(login);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NavigationBottomBar()));
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      image: tools.image_tools != ''
                                          ? NetworkImage(
                                              "${link}/img/${tools.image_tools}")
                                          : AssetImage(
                                              "images/svg/placeIMG.png"),
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
                                      color: Colors.black87,
                                      size: MediaQuery.of(context).size.height /
                                          42,
                                    ),
                                    Text(
                                      "   ${tools.lokasi_tools}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: defaultPadding),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "${tools.merk} ${tools.type} - ${tools.nama_tools}",
                                  textAlign: TextAlign.start,
                                  //widget.kodeTools.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: mainColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 15.0, top: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "${tools.thn_masuk}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black87),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "•",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black87),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "${tools.stok_akhir} / ${tools.stok_awal}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black87),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "•",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black87),
                                  ),
                                ),
                                Text(
                                  "${tools.bahan}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                )
                              ],
                            ),
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
                                    MediaQuery.of(context).size.width / 10,
                                child: RaisedButton(
                                  onPressed: _isButtonDisabled ? null : pinjam,
                                  disabledColor: Colors.black12,
                                  elevation: 5.0,
                                  disabledTextColor: Colors.black26,
                                  padding:
                                      new EdgeInsets.symmetric(vertical: 15),
                                  color: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  textColor: mainColor2,
                                  child: Text(
                                    "Pinjam",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
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
                                      MediaQuery.of(context).size.width / 10,
                                  margin: new EdgeInsets.only(top: 12),
                                  child: FlatButton(
                                      onPressed: () {
                                        kembali();
                                      },
                                      color: Colors.black12,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      padding: new EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: mainColor,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w600,
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
