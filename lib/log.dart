import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/constant.dart';
import 'package:http/http.dart' as http;

import 'package:my_app/model.dart';

class LogPeminjaman extends StatefulWidget {
  @override
  _LogPeminjamanState createState() => _LogPeminjamanState();
}

class _LogPeminjamanState extends State<LogPeminjaman> {
  FlutterSecureStorage storage;
  String value_login = '';
  String no_user = '';
  String login = '';

  String colorTheme = '';

  int length_data = 0;
  var data = '';
  var data_array = [];
  Peminjaman peminjaman;
  Future<Peminjaman> pinjam() async {
    log(no_user);
    await http
        .get("${link}/log_pinjam.php?no_user=${no_user}")
        .then((response) {
      var json = jsonDecode(response.body);
      length_data = json.length;
      while (length_data > 0) {
        data_array.add(json);
        length_data--;
      }

      setState(() {
        length_data = json.length;
      });
      log("message${json.length.toString()}");
    }).catchError((onError) {
      log(onError.toString());
    });
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
    pinjam();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();

    var riwayat = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Riwayat",
          style: TextStyle(
              fontSize: 20, color: Colors.black54, letterSpacing: 1.0),
        ),
      ],
    );
    var messageBar = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: <Widget>[
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
                        text: ' belum dikembalikan',
                        style: TextStyle(fontWeight: FontWeight.normal))
                  ])),
            ],
          ),
        )
      ],
    );
    return Scaffold(
        body: SafeArea(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Container(
          color: bgColor,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              riwayat,
              messageBar,
            ],
          ),
        ),
        Divider(
          color: mainColor2,
          height: 0,
          thickness: 2.5,
          indent: 10,
          endIndent: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: length_data,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // print(data_array[0][index].toString());
              Color color;
              peminjaman =
                  Peminjaman.fromJson(jsonDecode(data_array[0][index]));
              print(peminjaman.tgl_pinjam);
              var tgl = DateTime.parse(peminjaman.tgl_pinjam);
              var now = new DateTime.now();

              var first = "${tgl.hour}:${tgl.minute}:${tgl.second}";
              var last = "${tgl.hour + 8}:${tgl.minute}:${tgl.second}";
              var tgl_first = "${tgl.day}-${tgl.month}-${tgl.year}";
              var status = '';
              var difference = now.difference(tgl).inHours;
              if (difference > 24) {
                color = Colors.red;
                status = "Terlambat";
              } else if (difference > 10 && difference < 24) {
                color = mainColor2;
                status = "Segera";
              } else {
                color = mainColor;
                status = "Aktif";
              }

              if (peminjaman.status == "kembali") {
                color = Colors.black54;
                status = "Dikembalikan";
              }
              var container = Container(
                color: bgColor,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 30.0,
                                height: 30.0,
                                padding: EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  backgroundColor: color,
                                  radius: 20.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 5.0, bottom: 5.0, left: 15.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      peminjaman.nama_tools,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.0,
                                          color: color,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      '''${tgl_first}   (${status})
                                      ''',
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: color,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '${first}   s/d   ${last}',
                                      style: TextStyle(
                                          letterSpacing: 1.0,
                                          color: Colors.black54,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              return container;
            },
          ),
        ),
        SizedBox(height: 20)
      ]),
    ));
  }
}
