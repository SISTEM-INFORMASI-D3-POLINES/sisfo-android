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
  int jumlah_length = 0;
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
        jumlah_length = json.length;
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

    var riwayat = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            "Riwayat Pinjam",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          child: Text(
            "Riwayat peminjaman yang telah dilakukan. ",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
    var messageBar = Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 0),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
                text: jumlah_length.toString(),
                style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 13,
                    color: Colors.red),
                children: <TextSpan>[
                  TextSpan(
                      text: ' alat belum dikembalikan',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ]),
          ),
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffe6edf4),
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Image.asset(
            "images/svg/logo_header.png",
            alignment: Alignment.centerLeft,
            width: 160,
          ),
          centerTitle: false,
        ),
        backgroundColor: bgColor,
        body: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Container(
              color: bgColor,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [riwayat],
              ),
            ),
            // Divider(
            //   color: mainColor,
            //   height: 0,
            //   thickness: 2.5,
            //   indent: 0,
            //   endIndent: 0,
            // ),
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
                  var tgl_last = tgl.add(new Duration(hours: 5));
                  var last1 = DateTime.parse(tgl_last.toIso8601String());
                  var last =
                      "${last1.year}-${last1.month}-${last1.day} ${last1.hour}:${last1.minute}:${last1.second}";
                  var tgal = "${last1.year}-${last1.month}-${last1.day}";
                  var tgl_first = "${tgl.day}-${tgl.month}-${tgl.year}";
                  var status = '';
                  var difference = now.difference(tgl).inHours;

                  if (peminjaman.status == "kembali" &&
                      peminjaman.approval_kembali == "disetujui") {
                    color = Colors.black54;

                    status = "Dikembalikan";
                  } else if (peminjaman.status == "kembali" &&
                      peminjaman.approval_kembali == "diajukan") {
                    color = Colors.black54;
                    status = "Menunggu";
                  } else {
                    if (difference > 12) {
                      color = Colors.red;
                      status = "Terlambat";
                    } else if (difference > 5 && difference < 12) {
                      color = mainColor2;
                      status = "Segera";
                    } else {
                      color = mainColor;
                      status = "Aktif";
                    }
                  }

                  var kondisi = '';
                  if (peminjaman.kondisi_pinjam == "baik") {
                    kondisi = "Kondisi Baik";
                  }
                  log(status);
                  var container = Container(
                    color: bgColor,
                    width: MediaQuery.of(context).size.width,
                    margin: index == length_data - 1
                        ? EdgeInsets.only(bottom: 90)
                        : EdgeInsets.only(bottom: 0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    child: GestureDetector(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          peminjaman.nama_tools,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                              color: color,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          '''${tgal}   (${status})
                                      ''',
                                          style: TextStyle(
                                              letterSpacing: 0.5,
                                              color: color,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '${first}   s/d   ${last}',
                                          style: TextStyle(
                                              letterSpacing: 0.5,
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
            Container(
                color: bgColor,
                child: SizedBox(
                  height: 20,
                  child: Container(
                    color: bgColor,
                  ),
                ))
          ]),
        ));
  }

  modal(BuildContext context, int index) {
    Color color;

    peminjaman = Peminjaman.fromJson(jsonDecode(data_array[0][index]));
    print(peminjaman.tgl_pinjam);
    var tgl = DateTime.parse(peminjaman.tgl_pinjam);
    var now = new DateTime.now();

    var first = "${tgl.hour}:${tgl.minute}:${tgl.second}";
    var tgl_last = tgl.add(new Duration(hours: 8));
    var last1 = DateTime.parse(tgl_last.toIso8601String());
    var last =
        "${last1.year}-${last1.month}-${last1.day} ${last1.hour}:${last1.minute}:${last1.second}";
    var tgl_first = "${tgl.year}-${tgl.month}-${tgl.day}";
    var status = '';
    var difference = now.difference(tgl).inHours;
    if (peminjaman.status == "kembali" &&
        peminjaman.approval_kembali == "disetujui") {
      color = Colors.black54;
      status = "Dikembalikan";
    } else if (peminjaman.status == "kembali" &&
        peminjaman.approval_kembali == "diajukan") {
      color = Colors.black54;
      status = "Menunggu";
    } else {
      if (difference > 12) {
        color = Colors.red;
        status = "Terlambat";
      } else if (difference > 5 && difference < 12) {
        color = mainColor2;
        status = "Segera";
      } else {
        color = mainColor;
        status = "Aktif";
      }
    }
    var kondisi = '';
    if (peminjaman.kondisi_pinjam == "baik") {
      kondisi = "Kondisi Baik";
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      peminjaman.nama_tools,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 16,
                          height: 0.5,
                          color: mainColor),
                    ),
                    Text(
                      peminjaman.lokasi_tools,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14, letterSpacing: 0.5, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Container(
                color: bgColor,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Peminjaman",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 18,
                          color: mainColor),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Status",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 2)),
                              Text("Kode",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 2)),
                              Text("Tanggal",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 2)),
                              Text("Batas Waktu",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 2)),
                              Text("Kondisi Pinjam",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 2))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    " ${status} ",
                                    style: TextStyle(
                                        backgroundColor: color,
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.5,
                                        height: 2),
                                  )),
                              Text(
                                "${peminjaman.id_pinjam}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    height: 2),
                              ),
                              Text(
                                "${peminjaman.tgl_pinjam}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    height: 2),
                              ),
                              Text(
                                "${last}",
                                // "${tgl_first} ${last}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                    height: 2),
                              ),
                              Text(
                                "${kondisi}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    height: 2),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
