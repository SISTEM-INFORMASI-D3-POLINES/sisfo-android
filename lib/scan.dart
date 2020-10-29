import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'Detail.dart';
import 'bottomNav.dart';
import 'constant.dart';
import 'package:connectivity/connectivity.dart';

class ScanViewDemo extends StatefulWidget {
  ScanViewDemo({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ScanViewDemoState createState() => _ScanViewDemoState();
}

class _ScanViewDemoState extends State<ScanViewDemo> {
  String _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailTools(code)));
  }

  _connectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _scanCode();
    } else {
      _showAlertConnectionDialog();
    }
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  Future<void> _showAlertConnectionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Internet Tidak Terhubung',
            style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Smartphone tidak terhubung dengan Internet. hubungkan dengan internet untuk pinjam tools.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Kembali',
                style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationBottomBar()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _connectivity();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe6edf4),
        iconTheme: IconThemeData(
          color: mainColor,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        elevation: 0,
        title: Image.asset(
          "images/svg/logo_header.png",
          alignment: Alignment.centerLeft,
          width: 140,
        ),
        centerTitle: false,
      ),
      body: _camState
          ? Center(
              child: SizedBox(
                height: 1000,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    _qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Text(_qrInfo),
            ),
    );
  }
}
