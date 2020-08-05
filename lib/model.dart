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

class Tools {
  final String id_tools;
  final String nama_tools;
  final String merk;
  final String type;
  final String bahan;
  final String spesifikasi;
  final String satuan;
  final int stok_awal;
  final int stok_akhir;
  final String thn_masuk;
  final String desk_tools;
  final String lokasi_tools;
  final String image_tools;

  Tools(
      {this.id_tools,
      this.nama_tools,
      this.merk,
      this.type,
      this.bahan,
      this.spesifikasi,
      this.satuan,
      this.stok_awal,
      this.stok_akhir,
      this.thn_masuk,
      this.desk_tools,
      this.lokasi_tools,
      this.image_tools});

  factory Tools.fromJson(Map<String, dynamic> json) {
    return Tools(
        id_tools: json['id_tools'],
        nama_tools: json['nama_tools'],
        merk: json['merk'],
        type: json['type'],
        bahan: json['bahan'],
        spesifikasi: json['spesifikasi'],
        satuan: json['satuan'],
        stok_awal: json['satuan_awal'],
        stok_akhir: json['satuan_akhir'],
        thn_masuk: json['thn_masuk'],
        desk_tools: json['desk_tools'],
        lokasi_tools: json['lokasi_tools'],
        image_tools: json['image_tools']);
  }
}
