import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/constant.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class CariPage extends StatefulWidget {
  @override
  _CariPageState createState() => _CariPageState();
}

class _CariPageState extends State<CariPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final cariController = TextEditingController();

  String textChange;
  List lokasi = ['Lab-Timur 2', 'Lab-Timur-1'];
  int selectedIndex = 0;
  int index_page = 0;
  Tools tools;
  int stok = 0;
  bool isButtonDisabled = false;
  Color colorL;
  var toolsArray = [];
  int lengthData = 0;

  Future<Tools> getTools() async {
    await http.get("${link}/cari.php?index=${index_page}").then((response) {
      var jsonResponse = jsonDecode(response.body);
      print("jiuu" + jsonResponse.length.toString());
      lengthData = jsonResponse.length;

      if (jsonResponse != null) {
        while (lengthData > 0) {
          toolsArray.add(jsonResponse);
          lengthData--;
        }
        setState(() {
          lengthData = jsonResponse.length;
        });
      }
    });
    print(toolsArray[0].toString());
    return tools;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    cariController.addListener(onchange);
    getTools();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  onchange() {
    print(cariController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Color(0xffe6edf4),
          elevation: 0,
          title: Image.asset(
            "images/svg/logo_header.png",
            width: 140,
          ),
          centerTitle: false,
        ),
        body: Container(
          color: mainColor.withOpacity(0.05),
          child: Column(children: [
            cariBar(),
            lokasiTab(),
            SizedBox(height: defaultPadding / 2),
            Expanded(
                child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                ),
                ListView.builder(
                  itemCount: lengthData + 1,
                  itemBuilder: (context, index) {
                    final widgetItem = (index == lengthData)
                        ? new RaisedButton(onPressed: () {
                            setState(() {
                              index_page = index_page + 1;
                            });
                          })
                        : toolsBar(index);
                  },
                )
              ],
            ))
          ]),
        ),
      ),
    );
  }

  Container toolsBar(itemIndex) {
    tools = Tools.fromJson(jsonDecode(toolsArray[0][itemIndex]));
    print(tools.nama_tools);
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      // color: mainColor,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          height: 136,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [defaultShadow],
            color: mainColor,
          ),
          child: Container(
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              height: 100,
              width: 200,
              child: Container(
                height: 90,
                width: 90,
                padding: EdgeInsets.symmetric(
                    vertical: defaultPadding / 3,
                    horizontal: defaultPadding / 3),
                decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(width: 1.4, color: mainColor),
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image(
                    image: tools.image_tools != ""
                        ? NetworkImage("${link}/img/${tools.image_tools}")
                        : AssetImage("images/svg/placeIMG.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
        Positioned(
          child: Container(
            alignment: Alignment.centerLeft,
            // color: mainColor,
            width: 400,
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "${tools.nama_tools}",
                maxLines: 1,
                style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0),
              ),
            ),
          ),
        ),
        Positioned(
          child: Container(
            // color: mainColor,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width - 220,
              right: defaultPadding,
              top: defaultPadding + 3,
            ),
            padding: EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding / 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                "${tools.stok_akhir}/${tools.stok_akhir} ${tools.satuan}",
                style: TextStyle(
                    color: mainColor,
                    letterSpacing: 1.0,
                    height: 2,
                    fontSize: 13.5),
              ),
              Text(
                "${tools.lokasi_tools}",
                style: TextStyle(
                    color: Colors.grey[400],
                    letterSpacing: 1.0,
                    height: 2,
                    fontSize: 13.5),
              ),
            ]),
          ),
        )
      ]),
    );
  }

  Container lokasiTab() {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: defaultPadding / 4, horizontal: defaultPadding / 4),
        height: 40,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lokasi.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: defaultPadding / 1 - 3,
                        right: index == lokasi.length - 1 ? defaultPadding : 0),
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2,
                        vertical: defaultPadding / 2),
                    decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? mainColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      lokasi[index],
                      style: TextStyle(
                          color: mainColor,
                          letterSpacing: 1.0,
                          fontSize: 13,
                          fontWeight: index == selectedIndex
                              ? FontWeight.w600
                              : FontWeight.normal),
                    ),
                  ),
                )));
  }

  Container cariBar() {
    return Container(
      margin: EdgeInsets.all(defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 10),
      decoration: BoxDecoration(
          color: mainColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: cariController,
        onChanged: onchange(),
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            alignLabelWithHint: true,
            focusedBorder: InputBorder.none,
            hintText: 'Cari Alat',
            hintStyle:
                TextStyle(fontSize: 14, color: mainColor, letterSpacing: 1.0),
            icon: Icon(
              Icons.search,
              color: mainColor,
            )),
      ),
    );
  }
}
