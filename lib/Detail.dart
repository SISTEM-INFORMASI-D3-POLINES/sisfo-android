import 'dart:convert';
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
        .get(link + "/search.php?code=" + widget.kodeTools)
        .then((response) {
      if (response.statusCode == 200) {
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
        return tools;
      } else {
        _showAlertGalatGetToolsDialog();
      }
    });
  }

  Future<void> _showAlertGalatGetToolsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pindai Gagal',
            style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Pemindaian Alat Gagal. Terdapat masalah di koneksi internet atau sistem dalam perbaikan. Coba pindai ulang'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Pindai Ulang',
                style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/ScanPage');
              },
            ),
          ],
        );
      },
    );
  }

  Text txt = Text("0");
  String postPinjam;
  Peminjaman pinjamx;
  Future<Peminjaman> pinjam() async {
    await http
        .get(link +
            "/pinjam.php?noUser=" +
            _noUser +
            "&&id_tools=${tools.id_tools}&&jml_pinjam=${_n.toString()}&&stok_akhir=${tools.stok_akhir}&&kondisi_pinjam=${tools.desk_tools}")
        .then((response) {
      if (response != null) {
        _showDialogSuccessPinjam();
      }
    }).catchError((error) {});
    return pinjamx;
  }

  void _showDialogSuccessPinjam() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              new Icon(Icons.check_circle_outline, color: mainColor, size: 44),
          content: RichText(
            text: TextSpan(
              text: '',
              style: TextStyle(
                  fontFamily: 'Open Sans', fontSize: 15, color: mainColor),
              children: <TextSpan>[
                TextSpan(
                    text: tools.nama_tools,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: mainColor)),
                TextSpan(
                    text: ' berhasil dipinjam!',
                    style: TextStyle(color: mainColor)),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Kembali",
                style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/MainPage');
              },
            ),
          ],
        );
      },
    );
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

    var _jsonValueLogin = jsonDecode(_valueLogin);

    setState(() {
      _noUser = _jsonValueLogin['no_user'];
      login = _jsonValueLogin.toString();
    });
  }

  Future kembali() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NavigationBottomBar()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Builder(builder: (BuildContext context) {
        return Container(
          child: tools == null
              ? Text("Kode tools tidak ditemukan")
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
                                            ? NetworkImage(link +
                                                "/img/" +
                                                tools.image_tools)
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
                                        size:
                                            MediaQuery.of(context).size.height /
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    onPressed:
                                        _isButtonDisabled ? null : pinjam,
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
        );
      })),
    );
  }
}
