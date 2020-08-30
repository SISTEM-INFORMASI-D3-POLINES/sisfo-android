import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/constant.dart';
import 'package:my_app/model.dart';
import 'package:http/http.dart' as http;

class PesanNotification extends StatefulWidget {
  @override
  _PesanNotificationState createState() => _PesanNotificationState();
}

class _PesanNotificationState extends State<PesanNotification>
    with SingleTickerProviderStateMixin {
  FlutterSecureStorage storage;
  String value_login = '';
  String no_user = '';
  String login = '';
  AnimationController _controller;

  var msgArr = [];
  int lengthData = 0;
  var msgString = '';
  Msg msg;

  Future<Msg> message() async {
    int i = 0;
    var msgStrtoArr = [];
    await http.get(link + "/msg.php?noUser=" + no_user).then((value) {
      var jsonValue = jsonDecode(value.body);
      var jsonmsgString = jsonDecode(msgString);
      msgStrtoArr.add(msgString);

      msgStrtoArr.insertAll(0, [jsonValue, jsonmsgString]);
      print("djfkds" + msgStrtoArr.toString());

      _encrypt("msg", msgStrtoArr.toString());

      read();
      setState(() {
        msgArr = msgStrtoArr;
        lengthData = jsonValue.length;
      });
    }).catchError((error) {});
    return msg;
  }

  void _encrypt(key, msg) async {
    await storage.write(key: key, value: msg);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    storage = FlutterSecureStorage();

    read();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void read() async {
    //read from the secure storage
    value_login = await storage.read(key: "login");
    var msgStorage = await storage.read(key: "msg");
    var json_value_login = jsonDecode(value_login);
    var nim = json_value_login["no_user"].toString();
    setState(() {
      msgString = msgStorage;
      no_user = nim;
      login = json_value_login.toString();
    });
    message();
  }

  @override
  Widget build(BuildContext context) {
    // print(jsonEncode(msgArr).toString());
    // print(lengthData.toString());
    print(msgArr.length);
    return Container(
      child: Text("jfhsk"),
    );
  }
}
