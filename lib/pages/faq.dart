import 'package:flutter/material.dart';
import 'package:tampilanakun/constant.dart';
import 'dart:developer';
import 'package:fluttericon/font_awesome5_icons.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tampilanakun/services/faqcard.dart';
import 'package:tampilanakun/services/faqclass.dart';

class FreqAQ extends StatefulWidget {
  @override
  _FreqAQState createState() => _FreqAQState();
}

class _FreqAQState extends State<FreqAQ> {
  List<Question> questions = [
    Question(tanya: 'Apa itu QR Code?', jawab: 'Kode QR atau biasa dikenal dengan QR Code adalah bentuk evolusi kode batang dari satu dimensi menjadi dua dimensi. Huruf Q dan R merupakan singkatan dari Quick Response. '),
    Question(tanya: 'Mengapa menggunakan QR Code?', jawab: 'QR Code memiliki kemampuan penyimpanan data yang lebih besar daripada kode batang, serta cukup dengan ponsel dan tidak perlu alat khusus.'),
    Question(tanya: 'Apa itu Pintools?', jawab: 'Pintools merupakan singkatan dari Pinjam Tools. Pintools adalah aplikasi sistem peminjaman tools untuk Laboratorium Timur yang dikembangkan oleh Hayati Qurrotul Uyun dan Muhammad Ekananda Alfandza Fajar dalam Tugas Akhirnya yang berjudul "Sistem Peminjaman Tools Menggunakan QR Code berbasis Android Di Politeknik Negeri Semarang" Tahun 2020.'),
    Question(tanya: 'Mengapa pakai Pintools?', jawab: 'Pintools dapat memudahkan proses peminjaman dan pengembalian tools, dengan penggunaan teknologi QR Code dan informasi mengenai stok tools yang tersedia berbasis Android'),
    Question(tanya: 'Bagaimana cara menggunakan Pintools?', jawab: 'Datang ke Laboratorium Timur. Login terlebih dahulu dengan NIM/NIP anda serta password yang telah diberikan, setelah itu sentuh tombol Pindai. Lakukan pemindaian QR Code pada barang yang telah ditempel QR Code.'),
    Question(tanya: 'Saya lupa Password, bagaimana cara untuk mereset password?', jawab: 'Pada antarmuka login, sentuh "Forgot Password?". ....'),
    Question(tanya: 'Bagaimana cara mencari alat di Pintools?', jawab: 'Pada menu bagian bawah, sentuh Cari. Kemudian, pada search bar ketik barang yang akan anda cari.'),
    Question(tanya: 'Bagaimana cara mengetahui riwayat peminjaman?', jawab: 'Pada menu bagian bawah, sentuh Log. Pada antarmuka Log terdapat seluruh riwayat peminjaman anda.'),
    Question(tanya: 'Laboratorium mana saja yang digunakan dalam aplikasi ini?', jawab: 'Saat ini, hanya Laboratorium Timur lantai 1 dan 2 pada Politeknik Negeri Semarang.'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('FAQ'),
        centerTitle: true,
      ),
//      body: Column(
//        children: questions.map((question) => Question(question: question,)).toList(),
//      ),
    );
  }
}
