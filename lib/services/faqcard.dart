import 'package:flutter/material.dart';
import 'package:tampilanakun/constant.dart';
import 'package:tampilanakun/pages/tentangkami.dart';
import 'package:tampilanakun/pages/kebijakanprivasi.dart';
import 'package:tampilanakun/pages/faq.dart';
import 'dart:developer';
import 'package:fluttericon/font_awesome5_icons.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tampilanakun/services/faqclass.dart';


class FaqCard extends StatelessWidget {

  final Question question;
  const FaqCard({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(
                question.tanya,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                question.jawab,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
      ),
    );
  }
}
