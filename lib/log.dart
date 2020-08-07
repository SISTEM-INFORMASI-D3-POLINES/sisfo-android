import 'package:flutter/material.dart';
import 'package:my_app/constant.dart';
import 'package:folding_cell/folding_cell.dart';

class LogPeminjaman extends StatefulWidget {
  final Data;
  LogPeminjaman({this.Data});

  @override
  _LogPeminjamanState createState() => _LogPeminjamanState();
}

class _LogPeminjamanState extends State<LogPeminjaman> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: bgColor,
            child: Column(
              children: <Widget>[
                Text(widget.Data,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mainColor)),
                _buildCell(context, 4, "tools")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCell(
    BuildContext context,
    int index,
    String name,
  ) {
    // same as previous video
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 5.0, right: 12.0),
      child: Material(
        color: Color(0xFFE511E5),
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: SimpleFoldingCell(
          frontWidget: Container(
            color: Color(0xFFE511E5),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width /
                      6, //full width get the 6 part
                  height: MediaQuery.of(context).size.width / 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2.0),
                      image: DecorationImage(
                          image: AssetImage('assets/download.png'))),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Hollywood Actor',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '***** ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 30.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '(1.5 k)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 10.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          innerTopWidget: Container(
            color: Color(0xFFE511E5),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.width / 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2.0),
                      image: DecorationImage(
                          image: AssetImage('assets/download.png'))),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Hollywood Actor',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Best Actor in the Industry',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '*****',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          innerBottomWidget: Container(
            color: Color(0xFFDBACDB),
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: FlatButton(
                onPressed: () {
                  final snackBar = SnackBar(
                    content: Text(
                      'Item $index clicked',
                    ),
                    duration: Duration(milliseconds: 500),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name +
                          ' is an American actor of screen and stage, film director, producer, screenwriter and singer. He began his career as a stage actor during the 1980s before obtaining supporting roles in film and television',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                textColor: Colors.black,
                padding: EdgeInsets.all(5.0),
                splashColor: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          cellSize: Size(MediaQuery.of(context).size.width, 90),
          padding: EdgeInsets.all(5),
        ),
      ),
    );
  }
}
