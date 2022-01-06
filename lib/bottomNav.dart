import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'HomePage.dart';
import 'akun.dart';
import 'cari.dart';
import 'log.dart';

import 'constant.dart';

class NavigationBottomBar extends StatefulWidget {
  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    CariPage(),
    LogPeminjaman(),
    Akun(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        _children[_currentIndex],
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: bottomNavigationBar,
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 3,
          right: MediaQuery.of(context).size.width / 3,
          bottom: 35,
          child: FloatingActionButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/ScanPage');
            },
            child: Icon(FontAwesome5.qrcode),
            backgroundColor: mainColor,
          ),
        ),
      ]),
    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: Stack(children: [
        BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTappedBar,
            elevation: 0,
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesome5.home,
                  color: mainColor,
                  size: 20,
                ),
                title: new Text(
                  "Beranda",
                  style: TextStyle(color: mainColor),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesome5.search,
                  color: mainColor,
                  size: 20,
                ),
                title: new Text(
                  "Cari",
                  style: TextStyle(color: mainColor),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesome5.history,
                  color: mainColor,
                  size: 20,
                ),
                title: new Text(
                  "Log",
                  style: TextStyle(color: mainColor),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesome5.user,
                  color: mainColor,
                  size: 20,
                ),
                title: new Text(
                  "Akun",
                  style: TextStyle(color: mainColor),
                ),
              ),
            ]),
      ]),
    );
  }
}
