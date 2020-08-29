import 'package:flutter/material.dart';
import 'constant.dart';
import 'dart:developer';
import 'package:fluttericon/font_awesome5_icons.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TentangKami extends StatefulWidget {
  @override
  _TentangKamiState createState() => _TentangKamiState();
}

class _TentangKamiState extends State<TentangKami> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        iconTheme: IconThemeData(
          color: mainColor,
        ),
        title: Image.asset(
          "images/svg/logo_header.png",
          alignment: Alignment.centerLeft,
          width: 140,
        ),
        centerTitle: false,
      ),
      body: ListView(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Tentang Kami',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: mainColor),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Image(
              image: AssetImage('images/svg/just_logo.png'),
              height: 80,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              padding: EdgeInsets.all(15),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  boxShadow: [defaultShadow],
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                'Pintools adalah aplikasi sistem peminjaman tools untuk Laboratorium Timur. Pintools merupakan singkatan dari Pinjam Tools. Pintools dikembangkan berdasarkan kemajuan teknologi yang berkembang pesat dan semakin banyak penggunaan QR Code yang bertujuan agar memudahkan proses peminjaman dan pengembalian tools di Laboratorium Timur.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Container(
              child: Text(
                'Aplikasi ini dikembangkan oleh :',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              child: Text(
                'Hayati Qurrotul Uyun dan Muhammad Ekananda Alfandza Fajar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                'Dalam Tugas Akhirnya yang berjudul :',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              child: Text(
                'Sistem Peminjaman Tools Menggunakan QR Code berbasis Android Di Politeknik Negeri Semarang',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ]),
    );
  }
}
