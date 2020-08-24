import 'package:flutter/material.dart';
import 'package:tampilanakun/constant.dart';
import 'dart:developer';
import 'package:fluttericon/font_awesome5_icons.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
        backgroundColor: mainColor,
        title: Text('Tentang Kami'),
        centerTitle: true,
      ),
      body:
      ListView(
        children: <Widget> [
          Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0,),
            CircleAvatar(
              radius: 64.0,
              backgroundImage: AssetImage('images/logo_circle.png'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Pintools adalah aplikasi sistem peminjaman tools untuk Laboratorium Timur. Pintools merupakan singkatan dari Pinjam Tools. Pintools dikembangkan berdasarkan kemajuan teknologi yang berkembang pesat dan semakin banyak penggunaan QR Code yang bertujuan agar memudahkan proses peminjaman dan pengembalian tools di Laboratorium Timur.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12.0,
                  letterSpacing: 1.5,
                ),
                ),
            ),
            SizedBox(height: 1.0,),
            Container(
              child: Text('Aplikasi ini dikembangkan oleh :',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              child: Text('Hayati Qurrotul Uyun dan Muhammad Ekananda Alfandza Fajar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              child: Text('Dalam Tugas Akhirnya yang berjudul :',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              child: Text('Sistem Peminjaman Tools Menggunakan QR Code berbasis Android Di Politeknik Negeri Semarang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
  ]
      ),
    );
  }
}
