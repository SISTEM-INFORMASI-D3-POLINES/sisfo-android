import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/model.dart';

class block extends ChangeNotifier {
  List<Tools> _tools;
  List<Tools> get listTools => _tools;

  set listtools(List<Tools> val) {
    _tools = val;
    notifyListeners();
  }

  Future<List<Tools>> fetchlist() async {
    final response =
        await http.get("http://9d94cbbeccd9.ngrok.io/pintools_app_php/");
    List res = jsonDecode(response.body);
    List<Tools> data = [];

    for (var i = 0; i < res.length; i++) {
      var tools = Tools.fromJson(res[i]);
      data.add(tools);
    }
    return listTools;
  }
}
