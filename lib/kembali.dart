import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/constant.dart';
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
  String value_login = '';
  String no_user = '';
  String login = '';
  var id_pinjam = '';
  var _kondisi = '';
  var _tabTextIndexSelected = 0;
  var _tabTextIconIndexSelected = 0;
  var _tabIconIndexSelected = 0;

  // void logout() async {
  //   await storage.deleteAll().then((value) {}).then((value) => read());
  // }
  var jumlah = '';
  int length_data = 0;
  var data = '';
  var data_array = [];
  var json = [];
  Peminjaman peminjaman;
  Future<Peminjaman> kembali() async {
    log(no_user);
    await http
        .get("${link}/log_kembali.php?no_user=${no_user}")
        .then((response) {
      json = jsonDecode(response.body);
      length_data = json.length;
      while (length_data > 0) {
        data_array.add(json);
        length_data--;
      }

      setState(() {
        length_data = json.length;
        json = jsonDecode(response.body);
      });
      // log("message${json.length.toString()}");
      log("sih" + data_array[0].toString());
    }).catchError((onError) {
      log(onError.toString());
    });
    return peminjaman;
  }

  Future<Peminjaman> _kembaliControl(index, i, jumlah) async {
    var text = _tabTextIconIndexSelected;
    id_pinjam = index;
    if (text == 1) {
      _kondisi = 'rusak';
    } else {
      _kondisi = 'baik';
    }
    await http.post("${link}/kembali.php", body: {
      "noUser": no_user,
      'idPinjam': id_pinjam,
      'kondisi': _kondisi,
      'jumlah': jumlah
    }).then((value) {
      Navigator.of(context).pushReplacementNamed('/KembaliPage');
      log(i);
      setState(() {
        data_array[0].remove(i);
        data_array[0].removeItem(i);
      });
    }).catchError((onError) {});
    return peminjaman;
  }

  void initState() {
    super.initState();
    storage = FlutterSecureStorage();

    read();
    print(length_data);
  }

  void read() async {
    //read from the secure storage
    value_login = await storage.read(key: "login");

    var json_value_login = jsonDecode(value_login);
    var nim = json_value_login["no_user"].toString();
    setState(() {
      no_user = nim;
      login = json_value_login.toString();
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
                            text: length_data.toString(),
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
                  itemCount: length_data,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    peminjaman =
                        Peminjaman.fromJson(jsonDecode(data_array[0][index]));
                    var tgl = DateTime.parse(peminjaman.tgl_pinjam);
                    var now = new DateTime.now();

                    var first = "${tgl.hour}:${tgl.minute}:${tgl.second}";
                    var last = "${tgl.hour + 8}:${tgl.minute}:${tgl.second}";
                    var tgl_first = "${tgl.day}-${tgl.month}-${tgl.year}";
                    var status = '';
                    var difference = now.difference(tgl).inHours;
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            image: NetworkImage(
                                                "${link}/img/${peminjaman.image_tools}"),
                                            height: 60,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 15),
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
    peminjaman = Peminjaman.fromJson(jsonDecode(data_array[0][index]));
    print(peminjaman.tgl_pinjam);
    var tgl = DateTime.parse(peminjaman.tgl_pinjam);
    var now = new DateTime.now();

    var first = "${tgl.hour}:${tgl.minute}:${tgl.second}";
    var last = "${tgl.hour + 8}:${tgl.minute}:${tgl.second}";
    var tgl_now = "${now.day}-${now.month}-${now.year}";
    var tgl_first = "${tgl.day}-${tgl.month}-${tgl.year}";
    var status = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        var _thumbUp = Icons;
        var _listGenderText = ["Baik", "Rusak"];
        var _listGenderEmpty = ["", ""];
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
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border(
                              bottom: BorderSide(color: mainColor, width: 1),
                              left: BorderSide(color: mainColor, width: 1),
                              right: BorderSide(color: mainColor, width: 1),
                              top: BorderSide(color: mainColor, width: 1))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                      width: 80,
                      height: 80,
                      child: Image(
                        image: NetworkImage(
                            "${link}/img/${peminjaman.image_tools}"),
                      ),
                    ),
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
                            "${tgl_first}",
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
                            "${tgl_now}",
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
                      log(peminjaman.id_pinjam);
                      _kembaliControl(peminjaman.id_pinjam, index, jumlah);
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
