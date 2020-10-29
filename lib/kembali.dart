import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import 'model.dart';

class KembaliPage extends StatefulWidget {
  @override
  _KembaliPageState createState() => _KembaliPageState();
}

class _KembaliPageState extends State<KembaliPage> {
  FlutterSecureStorage storage;
  String _valueLogin = '';
  String _noUser = '';
  String login = '';
  var idPinjam = '';
  var _kondisi = '';
  var _tabTextIconIndexSelected = 0;
  var jumlah = '';
  int lengthData = 0;
  var data = '';
  var dataArray = [];
  var json = [];
  Peminjaman peminjaman;
  Future<Peminjaman> kembali() async {
    log(_noUser);
    await http
        .get(link + "/log_kembali.php?no_user=" + _noUser)
        .then((response) {
      json = jsonDecode(response.body);
      lengthData = json.length;
      while (lengthData > 0) {
        dataArray.add(json);
        lengthData--;
      }

      setState(() {
        lengthData = json.length;
        json = jsonDecode(response.body);
      });
    }).catchError((onError) {
      log(onError.toString());
    });
    return peminjaman;
  }

  Future<Peminjaman> _kembaliControl(index, i, jumlahKembali) async {
    print(index.toString() + i.toString() + jumlahKembali.toString());
    var text = _tabTextIconIndexSelected;
    idPinjam = index;
    if (text == 1) {
      _kondisi = 'rusak';
    } else {
      _kondisi = 'baik';
    }
    await http.post(link + "/kembali.php", body: {
      "noUser": _noUser,
      'idPinjam': idPinjam,
      'kondisi': _kondisi,
      'jumlah': jumlahKembali.toString()
    }).then((value) {
      _showDialogSuccessKembali(idPinjam);
      setState(() {
        dataArray[0].remove(i);
        dataArray[0].removeItem(i);
      });
    }).catchError((onError) {});
    return peminjaman;
  }

  void _showDialogSuccessKembali(idPinjam) {
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
                    text: idPinjam,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: mainColor)),
                TextSpan(
                    text:
                        ' telah diajukan. Tunggu approval dari staff beberapa saat lagi.',
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
    super.initState();
    storage = FlutterSecureStorage();

    read();
  }

  void read() async {
    //read from the secure storage
    _valueLogin = await storage.read(key: "login");

    var jsonValueLogin = jsonDecode(_valueLogin);
    var nim = jsonValueLogin["no_user"].toString();
    setState(() {
      _noUser = nim;
      login = jsonValueLogin.toString();
    });
    kembali();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe6edf4),
        iconTheme: IconThemeData(
          color: mainColor,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        elevation: 0,
        title: Image.asset(
          "images/svg/logo_header.png",
          alignment: Alignment.centerLeft,
          width: 140,
        ),
        centerTitle: false,
      ),
      backgroundColor: bgColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kembali",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        letterSpacing: 1.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: lengthData.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                fontSize: 13,
                                color: Colors.red),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' alat belum dikembalikan',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal))
                            ]),
                      ),
                    ]),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            )
          ]),
          Expanded(
              child: ListView.builder(
                  itemCount: lengthData,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    peminjaman =
                        Peminjaman.fromJson(jsonDecode(dataArray[0][index]));
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
                      color: bgColor,
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            modal(context, index);
                          },
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey[50],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 5.0),
                                          width: 60.0,
                                          child: Image(
                                            image: peminjaman.image_tools != ''
                                                ? NetworkImage(linkImage +
                                                    "/assets/img/tools/" +
                                                    peminjaman.image_tools)
                                                : AssetImage(
                                                    "images/svg/placeIMG.png"),
                                            height: 60,
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 75),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 15),
                                            child: Text(
                                              peminjaman.nama_tools,
                                              style: TextStyle(
                                                  color: mainColor,
                                                  letterSpacing: 1.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${peminjaman.jml_pinjam} ${peminjaman.satuan}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    letterSpacing: 1.0,
                                                    fontSize: 13),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 15.0),
                                                child: Text(
                                                  '${peminjaman.lokasi_tools}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      letterSpacing: 1.0,
                                                      fontSize: 13),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [],
                                    )
                                  ],
                                )),
                          ),
                        )
                      ]),
                    );
                  })),
        ],
      )),
    );
  }

  modal(BuildContext context, int index) {
    peminjaman = Peminjaman.fromJson(jsonDecode(dataArray[0][index]));
    var tgl = DateTime.parse(peminjaman.tgl_pinjam);
    var now = new DateTime.now();

    var tglNow = "${now.day}-${now.month}-${now.year}";
    var tglFirst = "${tgl.day}-${tgl.month}-${tgl.year}";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        var _listGenderText = ["Baik", "Rusak"];
        var _listIconTabToggle = [
          Icons.thumb_up,
          Icons.thumb_down,
        ];

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: defaultPadding / 2),
                      child: Text(
                        "${peminjaman.merk} ${peminjaman.type}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: mainColor),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        peminjaman.nama_tools.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            fontSize: 15,
                            height: 0.5,
                            color: mainColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: defaultPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${peminjaman.jml_pinjam} ${peminjaman.satuan}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1.0,
                                color: Colors.grey),
                          ),
                          Text(
                            "${peminjaman.lokasi_tools}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1.0,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black54.withOpacity(0.15),
                  height: 0,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pinjam",
                            style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1.0,
                                color: Colors.grey),
                          ),
                          Text(
                            tglFirst,
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1.0,
                                color: mainColor),
                          )
                        ])
                  ],
                ),
                Divider(
                  color: Colors.black54.withOpacity(0.15),
                  height: 0,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kembali",
                            style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1.0,
                                color: Colors.grey),
                          ),
                          Text(
                            tglNow,
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1.0,
                                color: mainColor),
                          )
                        ])
                  ],
                ),
                Divider(
                  color: Colors.black54.withOpacity(0.15),
                  height: 0,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Kondisi Alat",
                            style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1.0,
                                color: mainColor),
                          ),
                        ),
                        FlutterToggleTab(
                          width: 50,
                          height: 40,
                          initialIndex: 0,
                          borderRadius: 0,
                          selectedBackgroundColors: [mainColor],
                          unSelectedBackgroundColors: [Colors.blueGrey[50]],
                          selectedTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                          unSelectedTextStyle: TextStyle(
                              color: mainColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                          labels: _listGenderText,
                          icons: _listIconTabToggle,
                          selectedLabelIndex: (index) {
                            setState(() {
                              _tabTextIconIndexSelected = index;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 45,
                  child: RaisedButton(
                    elevation: 5.0,
                    color: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      _kembaliControl(
                          peminjaman.id_pinjam, index, peminjaman.jml_pinjam);
                    },
                    child: Text(
                      "Ajukan Kembali",
                      style: TextStyle(
                          color: mainColor2,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
