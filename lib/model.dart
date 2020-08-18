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
  final String stok_awal;
  final String stok_akhir;
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
        stok_awal: json['stok_awal'],
        stok_akhir: json['stok_akhir'],
        thn_masuk: json['thn_masuk'],
        desk_tools: json['desk_tools'],
        lokasi_tools: json['lokasi_tools'],
        image_tools: json['image_tools']);
  }
}

class Peminjaman {
  final String id_pinjam;
  final String no_user;
  final String nip_staff;
  final String id_tools;
  final String tgl_pinjam;
  final String jml_pinjam;
  final String kondisi_pinjam;
  final String approval_pinjam;
  final String tgl_kembali;
  final String jml_kembali;
  final String kondisi_kembali;
  final String approval_kembali;
  final String stok_terakhir;
  final String status;
  final String nama_tools;
  final String merk;
  final String type;
  final String bahan;
  final String spesifikasi;
  final String satuan;
  final String stok_awal;
  final String stok_akhir;
  final String thn_masuk;
  final String desk_tools;
  final String lokasi_tools;
  final String image_tools;

  Peminjaman(
      {this.id_pinjam,
      this.no_user,
      this.nip_staff,
      this.id_tools,
      this.tgl_pinjam,
      this.jml_pinjam,
      this.kondisi_pinjam,
      this.approval_pinjam,
      this.tgl_kembali,
      this.jml_kembali,
      this.kondisi_kembali,
      this.approval_kembali,
      this.stok_terakhir,
      this.status,
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

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
        id_pinjam: json['id_pinjam'],
        no_user: json['no_user'],
        nip_staff: json['nip_staff'],
        id_tools: json['id_tools'],
        tgl_pinjam: json['tgl_pinjam'],
        jml_pinjam: json['jml_pinjam'],
        kondisi_pinjam: json['kondisi_pinjam'],
        approval_pinjam: json['approval_pinjam'],
        tgl_kembali: json['tgl_kembali'],
        jml_kembali: json['jml_kembali'],
        kondisi_kembali: json['kondisi_kembali'],
        approval_kembali: json['approval_kembali'],
        stok_terakhir: json['stok_terakhis'],
        status: json['status'],
        nama_tools: json['nama_tools'],
        merk: json['merk'],
        type: json['type'],
        bahan: json['bahan'],
        spesifikasi: json['spesifikasi'],
        satuan: json['satuan'],
        stok_awal: json['stok_awal'],
        stok_akhir: json['stok_akhir'],
        thn_masuk: json['thn_masuk'],
        desk_tools: json['desk_tools'],
        lokasi_tools: json['lokasi_tools'],
        image_tools: json['image_tools']);
  }
}

class User {
  final String no_user;
  final String pass;

  User(this.no_user, this.pass);

  User.fromJson(Map<String, dynamic> json)
      : no_user = json['no_user'],
        pass = json['pass'];

  Map<String, dynamic> toJson() => {
        'no_user': no_user,
        'pass': pass,
      };
}
