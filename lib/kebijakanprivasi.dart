import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:url_launcher/url_launcher.dart';

class KebijakanPrivasi extends StatefulWidget {
  @override
  _KebijakanPrivasiState createState() => _KebijakanPrivasiState();
}

class _KebijakanPrivasiState extends State<KebijakanPrivasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        iconTheme: IconThemeData(
          color: mainColor,
        ),
        title: Image.asset(
          "images/svg/logo_header.png",
          alignment: Alignment.centerLeft,
          width: 140,
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Kebijakan Privasi',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 30, color: mainColor),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            padding: EdgeInsets.all(5),
            decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [defaultShadow],
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Tinjauan',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Kami menyadari bahwa privasi di Pintools merupakan hal penting bagi anda. Oleh sebab itu, kami ingin menjelaskan kepada anda bagaimana kami menggunakan informasi pribadi anda. Dengan menggunakan Pintools, anda setuju atas Kebijakan Privasi yang kami berikan.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Penggunaan Informasi pada Ponsel',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Untuk mendapatkan pengalaman terbaik ketika menggunakan aplikasi kami, kami menggunakan informasi personal yang dapat diidentifikasi. Berikut yang kami gunakan:',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Text(
                  '1. Membaca, mengubah atau menghapus konten di penyimpanan anda',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                child: Text(
                  '2. Mengakses kamera ponsel anda',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                child: Text(
                  '3. Menggunakan akses internet',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                child: Text(
                  '4. Menyimpan Cookie pada ponsel anda',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Kami tidak pernah menanyakan informasi pribadi anda seperti Email ataupun Kartu Kredit anda.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Pihak Ketiga',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Kami tidak menjual, menukarkan maupun memberikan informasi anda ke pihak ketiga serta kami tidak memasukkan / menawarkan produk atau servis pihak ketiga pada aplikasi kami.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            child: Text(
              'Dengan membaca Kebijakan Privasi, Pengguna Pintools dianggap sudah menyetujui sepenuhnya terhadap isi kebijakan privasi dan penggunaan informasi data pribadi yang telah diperoleh dan dimiliki Pintools. Jika ada pertanyaan mengenai Kebijakan Privasi, silahkan hubungi kami melalui Email dibawah ini :',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  color: mainColor,
                  onPressed: _createEmail1,
                  child: Text(
                    'Hayati Q Uyun',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                RaisedButton(
                  color: mainColor,
                  onPressed: _createEmail2,
                  child: Text(
                    'M. Ekananda',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _createEmail1() async {
  if (await canLaunch(mail1)) {
    await launch(mail1);
  } else {
    throw 'Could not Email';
  }
}

void _createEmail2() async {
  if (await canLaunch(mail2)) {
    await launch(mail2);
  } else {
    throw 'Could not Email';
  }
}
