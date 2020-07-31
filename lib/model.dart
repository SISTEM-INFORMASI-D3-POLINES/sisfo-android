import 'package:flutter/foundation.dart';

class Login {
  String id_user;
  String no_user;
  String pass;
  String level;
  String id_prodi;
  String id_kls;
  String kls;

  Login(
      {this.id_user,
      this.no_user,
      this.pass,
      this.level,
      this.id_prodi,
      this.id_kls,
      this.kls});
  factory Login.fromJson(Map<String, dynamic> parsedJson) {
    return Login(
        id_user: parsedJson['id_user'],
        no_user: parsedJson['no_user'],
        pass: parsedJson['pass'],
        level: parsedJson['level'],
        id_prodi: parsedJson['id_prodi'],
        id_kls: parsedJson['id_kls'],
        kls: parsedJson['kls']);
  }
}
