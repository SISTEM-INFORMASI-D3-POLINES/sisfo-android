import 'package:flutter/material.dart';
import 'package:tampilanakun/constant.dart';
import 'dart:developer';
import 'package:fluttericon/font_awesome5_icons.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

class KebijakanPrivasi extends StatefulWidget {
  @override
  _KebijakanPrivasiState createState() => _KebijakanPrivasiState();
}

class _KebijakanPrivasiState extends State<KebijakanPrivasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Kebijakan Privasi'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Tinjauan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Kami menyadari bahwa privasi di Pintools merupakan hal penting bagi anda. Oleh sebab itu, kami ingin menjelaskan kepada anda bagaimana kami menggunakan informasi pribadi anda. Dengan menggunakan Pintools, anda setuju atas Kebijakan Privasi yang kami berikan.',
              style: TextStyle(fontSize: 14),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Penggunaan Informasi pada Ponsel',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Untuk mendapatkan pengalaman terbaik ketika menggunakan aplikasi kami, kami menggunakan informasi personal yang dapat diidentifikasi. Berikut yang kami gunakan:',
              style: TextStyle(fontSize: 14),),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Text('1. Membaca, mengubah atau menghapus konten di penyimpanan anda',
              style: TextStyle(fontSize: 14),),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
            child: Text('2. Mengakses kamera ponsel anda',
              style: TextStyle(fontSize: 14),),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
            child: Text('3. Menggunakan akses internet',
              style: TextStyle(fontSize: 14),),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
            child: Text('4. Menyimpan Cookie pada ponsel anda',
              style: TextStyle(fontSize: 14),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Kami tidak pernah menanyakan informasi pribadi anda seperti Email ataupun Kartu Kredit anda.',
              style: TextStyle(fontSize: 14),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Pihak Ketiga',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Kami tidak menjual, menukarkan maupun memberikan informasi anda ke pihak ketiga serta kami tidak memasukkan / menawarkan produk atau servis pihak ketiga pada aplikasi kami.',
              style: TextStyle(fontSize: 14),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Kontak Kami',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Jika ada pertanyaan mengenai Kebijakan Privasi, silahkan hubungi kami melalui Email dibawah ini :',
              style: TextStyle(fontSize: 14),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  onPressed: null,
                child: Text('Hayati Uyun'),
              ),
              SizedBox(width: 5.0,),
              RaisedButton(
                  onPressed: null,
                child: Text('M. Ekananda'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
