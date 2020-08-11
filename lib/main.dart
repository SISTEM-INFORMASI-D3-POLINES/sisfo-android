import 'package:flutter/material.dart';
import 'package:tampilanakun/constant.dart';
import 'dart:developer';
import 'package:fluttericon/font_awesome5_icons.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(MaterialApp(
  home: Akun()
));

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 30.0,),
          SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: mainColor,
                    radius: 40.0,
                  ),
                  SizedBox(width: 10.0,),
                  Text(
                    'Testing Menu Akun',
                  style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                  ),
                  ),
                ],
              ),
          ),
          SizedBox(height: 30.0,),
          OutlineButton.icon(
            onPressed: (){},
            icon : Icon(Icons.mail),
            label : Text('Pesan'),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
          ),
          OutlineButton.icon(
              onPressed: (){},
              icon : Icon(Icons.vpn_key),
              label : Text('Ubah Password'),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
          ),
          OutlineButton.icon(
              onPressed: (){},
              icon : Icon(Icons.lock),
              label : Text('Kebijakan Privasi'),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
          ),
          OutlineButton.icon(
              onPressed: (){},
              icon : Icon(Icons.people),
              label : Text('Tentang Kami'),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
          ),
          OutlineButton.icon(
              onPressed: (){},
              icon : Icon(Icons.help),
              label : Text('FAQ'),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
          ),
          OutlineButton.icon(
              onPressed: (){},
              icon : Icon(Icons.subdirectory_arrow_right),
              label : Text('Keluar'),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          scan();
        },
        child: Icon(FontAwesome5.qrcode),
        backgroundColor: mainColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          notchMargin: 15,
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.home,
                      size: 26.0,
                      color: blackIcon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Icon(
                        Icons.search,
                        size: 26.0,
                        color: blackIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Icon(
                        Icons.history,
                        size: 26.0,
                        color: blackIcon,
                      ),
                    ),
                    Icon(
                      Icons.person,
                      size: 26.0,
                      color: blackIcon,
                    )
                  ]),
            ),
          )),
    );;
  }
}
