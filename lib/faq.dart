import 'package:flutter/material.dart';
import 'constant.dart';
import 'dart:developer';
import 'package:fluttericon/font_awesome5_icons.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'model.dart';
import 'package:my_app/services/faqcard.dart';

class FreqAQ extends StatefulWidget {
  @override
  _FreqAQState createState() => _FreqAQState();
}

class _FreqAQState extends State<FreqAQ> {
  List<Question> questions = [
    Question(
        tanya: 'Apa itu QR Code?',
        jawab:
            'Kode QR atau biasa dikenal dengan QR Code adalah bentuk evolusi kode batang dari satu dimensi menjadi dua dimensi. Huruf Q dan R merupakan singkatan dari Quick Response. '),
    Question(
        tanya: 'Mengapa menggunakan QR Code?',
        jawab:
            'QR Code memiliki kemampuan penyimpanan data yang lebih besar daripada kode batang, serta cukup dengan ponsel dan tidak perlu alat khusus.'),
    Question(
        tanya: 'Apa itu Pintools?',
        jawab:
            'Pintools merupakan singkatan dari Pinjam Tools. Pintools adalah aplikasi sistem peminjaman tools untuk Laboratorium Timur yang dikembangkan oleh Hayati Qurrotul Uyun dan Muhammad Ekananda Alfandza Fajar dalam Tugas Akhirnya yang berjudul "Sistem Peminjaman Tools Menggunakan QR Code berbasis Android Di Politeknik Negeri Semarang" Tahun 2020.'),
    Question(
        tanya: 'Mengapa pakai Pintools?',
        jawab:
            'Pintools dapat memudahkan proses peminjaman dan pengembalian tools, dengan penggunaan teknologi QR Code dan informasi mengenai stok tools yang tersedia berbasis Android'),
    Question(
        tanya: 'Bagaimana cara menggunakan Pintools?',
        jawab:
            'Datang ke Laboratorium Timur. Login terlebih dahulu dengan NIM/NIP anda serta password yang telah diberikan, setelah itu sentuh tombol Pindai. Lakukan pemindaian QR Code pada barang yang telah ditempel QR Code.'),
    Question(
        tanya: 'Saya lupa Password, bagaimana cara untuk mereset password?',
        jawab:
            'Silahkan reset password Anda dengan menghubungi admin melalui admin@email.com atau dengan mendatangi Unit Pelayanan Terpadu Teknologi Informasi dan Komunikasi Politeknik Negeri Semarang. Informasi ini juga terdapat pada antarmuka Login pada "Lupa Password".'),
    Question(
        tanya: 'Bagaimana cara mencari alat di Pintools?',
        jawab:
            'Pada menu bagian bawah, sentuh Cari. Kemudian, pada search bar ketik barang yang akan anda cari.'),
    Question(
        tanya: 'Bagaimana cara mengetahui riwayat peminjaman?',
        jawab:
            'Pada menu bagian bawah, sentuh Log. Pada antarmuka Log terdapat seluruh riwayat peminjaman anda.'),
    Question(
        tanya: 'Laboratorium mana saja yang digunakan dalam aplikasi ini?',
        jawab:
            'Saat ini, hanya Laboratorium Timur lantai 1 dan 2 pada Politeknik Negeri Semarang.'),
  ];

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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "FAQ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: mainColor, fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: questions
                .map((question) => FaqCard(
                      question: question,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
