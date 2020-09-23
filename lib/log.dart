import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/constant.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_app/model.dart';

class LogPeminjaman extends StatefulWidget {
  @override
  _LogPeminjamanState createState() => _LogPeminjamanState();
}

class _LogPeminjamanState extends State<LogPeminjaman> {
  FlutterSecureStorage storage;
  String _valueLogin = '';
  String _noUser = '';
  String login = '';

  String colorTheme = '';

  int lengthData = 0;
  int jumlahLength = 0;
  var data = '';
  var dataArray = [];
  Peminjaman peminjaman;
  Future<Peminjaman> pinjam() async {
    await http
        .get(link + "/log_pinjam.php?no_user=" + _noUser)
        .then((response) {
      var json = jsonDecode(response.body);
      lengthData = json.length;
      while (lengthData > 0) {
        dataArray.add(json);
        lengthData--;
      }

      setState(() {
        lengthData = json.length;
        jumlahLength = json.length;
      });
    }).catchError((onError) {
      log(onError.toString());
    });
    return peminjaman;
  }

  void initState() {
    super.initState();
    storage = FlutterSecureStorage();

    read();
  }

  void read() async {
    //read from the secure storage
    _valueLogin = await storage.read(key: "login");

    var jsonValueLoginFromKeystore = jsonDecode(_valueLogin);
    var nim = jsonValueLoginFromKeystore["no_user"].toString();
    setState(() {
      _noUser = nim;
      login = jsonValueLoginFromKeystore.toString();
    });
    pinjam();
  }

  @override
  Widget build(BuildContext context) {
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
                itemCount: lengthData,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Color color;

                  peminjaman =
                      Peminjaman.fromJson(jsonDecode(dataArray[0][index]));
                  var tgl = DateTime.parse(peminjaman.tgl_pinjam);
                  var now = new DateTime.now();

                  var first = "${tgl.hour}:${tgl.minute}:${tgl.second}";
                  final startTime =
                      DateTime(tgl.year, tgl.month, tgl.day, 07, 00);
                  final startTime2 =
                      DateTime(tgl.year, tgl.month, tgl.day, 09, 00);

                  final endTime =
                      DateTime(tgl.year, tgl.month, tgl.day, 13, 30);
                  final endTime2 =
                      DateTime(tgl.year, tgl.month, tgl.day, 15, 30);
                  DateTime tg1;

                  if (tgl.isAfter(startTime) && tgl.isBefore(endTime)) {
                    tg1 = endTime;
                  } else if (tgl.isAfter(startTime2) &&
                      tgl.isBefore(endTime2)) {
                    tg1 = endTime2;
                  } else {
                    tg1 = endTime;
                  }
                  var tg = DateFormat("yyyy-MM-dd HH:mm:ss").format(tg1);

                  var tgal = "${tgl.year}-${tgl.month}-${tgl.day}";

                  var status = '';
                  if (peminjaman.status == "kembali" &&
                      peminjaman.approval_kembali == "disetujui") {
                    color = Colors.black54;

                    status = "Dikembalikan";
                  } else if (peminjaman.status == "kembali" &&
                      peminjaman.approval_kembali == "diajukan") {
                    color = Colors.black54;
                    status = "Menunggu";
                  } else {
                    if (now.isAfter(tg1)) {
                      color = Colors.red;
                      status = "Terlambat";
                    } else if (now.hour > (tg1.hour - 2) &&
                        now.hour < (tg1.hour)) {
                      color = mainColor2;
                      status = "Segera";
                    } else {
                      color = mainColor;
                      status = "Aktif";
                    }
                  }

                  var container = Container(
                    color: bgColor,
                    width: MediaQuery.of(context).size.width,
                    margin: index == lengthData - 1
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
                          child: Stack(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 35),
                                  child: Column(
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
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        tgal + '   ' + status,
                                        style: TextStyle(
                                            letterSpacing: 0.5,
                                            color: color,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        first + '   s/d   ' + tg,
                                        style: TextStyle(
                                            letterSpacing: 0.5,
                                            color: Colors.black54,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 30,
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                padding: EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  backgroundColor: color,
                                  radius: 20.0,
                                ),
                              ),
                            ),
                          ]),
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

    peminjaman = Peminjaman.fromJson(jsonDecode(dataArray[0][index]));
    var tgl = DateTime.parse(peminjaman.tgl_pinjam);
    var now = new DateTime.now();

    final startTime = DateTime(tgl.year, tgl.month, tgl.day, 07, 00);
    final startTime2 = DateTime(tgl.year, tgl.month, tgl.day, 09, 00);

    final endTime = DateTime(tgl.year, tgl.month, tgl.day, 13, 30);
    final endTime2 = DateTime(tgl.year, tgl.month, tgl.day, 15, 30);
    DateTime tg1;

    if (tgl.isAfter(startTime) && tgl.isBefore(endTime)) {
      tg1 = endTime;
    } else if (tgl.isAfter(startTime2) && tgl.isBefore(endTime2)) {
      tg1 = endTime2;
    } else {
      tg1 = endTime;
    }
    var tg = DateFormat("yyyy-MM-dd HH:mm:ss").format(tg1);

    var status = '';
    if (peminjaman.status == "kembali" &&
        peminjaman.approval_kembali == "disetujui") {
      color = Colors.black54;

      status = "Dikembalikan";
    } else if (peminjaman.status == "kembali" &&
        peminjaman.approval_kembali == "diajukan") {
      color = Colors.black54;
      status = "Menunggu";
    } else {
      if (now.isAfter(tg1)) {
        color = Colors.red;
        status = "Terlambat";
      } else if (now.hour > (tg1.hour - 2) && now.hour < (tg1.hour)) {
        color = mainColor2;
        status = "Segera";
      } else {
        color = mainColor;
        status = "Aktif";
      }
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
                                    " " + status + " ",
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
                                tg,
                                // "${tgl_first} ${last}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                    height: 2),
                              ),
                              Text(
                                peminjaman.kondisi_pinjam,
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
