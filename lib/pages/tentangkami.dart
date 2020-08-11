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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Tentang Kami'),
        centerTitle: true,
      ),
    );
  }
}
