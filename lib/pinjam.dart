import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:my_app/constant.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class PinjamPage extends StatefulWidget {
  @override
  _PinjamPageState createState() => _PinjamPageState();
}

class _PinjamPageState extends State<PinjamPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final cariController = TextEditingController();
  bool isSearch = false;
  var textSearch;
  String textChange;
  bool isSelected = false;
  List lokasi = ['Lab Timur-01', 'Lab Timur-02'];
  int selectedIndex = 0;
  int indexPage = 0;
  Tools tools;
  int stok = 0;
  bool isButtonDisabled = false;
  Color colorL;
  List<Tools> toolsArray = List<Tools>();
  int lengthData = 0;
  List<Tools> toolsObj = List<Tools>();

  // var response = await http.get("${link}/cari.php?index=${indexPage}");
  Future<List<Tools>> getTools() async {
    var url = link + '/cari_pinjam.php?index=' + indexPage.toString();
    var response = await http.get(url);

    var notes = List<Tools>();

    if (response.statusCode == 200) {
      var notesJson = jsonDecode(response.body);

      for (var noteJson in notesJson) {
        notes.add(Tools.fromJson(jsonDecode(noteJson)));
      }
    }
    return notes;
  }

  Future scan() async {
    Navigator.pushNamed(context, '/ScanPage');
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getTools().then((value) {
      setState(() {
        toolsObj.addAll(value);
        toolsArray = toolsObj;
      });
    });
  }

  void loadMore() {
    getTools().then((value) {
      setState(() {
        toolsObj = value;
        toolsArray = toolsObj;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: bgColor,
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
                toolsArray.length != 0
                    ? ListView.builder(
                        itemCount: toolsArray.length + 1,
                        itemBuilder: (context, index) {
                          final widgetItem = (index == toolsArray.length)
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 30),
                                    child: new RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          indexPage = indexPage + 1;
                                        });
                                        loadMore();
                                      },
                                      color: mainColor.withOpacity(0.1),
                                      elevation: 0,
                                      textColor: mainColor,
                                      child: Text("Muat Lebih"),
                                    ),
                                  ),
                                )
                              : toolsBar(index);
                          return widgetItem;
                        },
                      )
                    : blankData()
              ],
            ))
          ]),
        ),
      ),
    );
  }

  Center blankData() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 80),
          width: MediaQuery.of(context).size.height / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage("images/svg/placeIMG.png"),
                  width: MediaQuery.of(context).size.height / 5),
              Text(
                "Tidak ada alat yang tersedia. Konfirmasi ke Laboratorium untuk memastikan ketersediaan alat.",
                textAlign: TextAlign.center,
                style: TextStyle(color: mainColor, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container toolsBar(itemIndex) {
    tools = toolsArray[itemIndex];
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      // color: mainColor,
      child: GestureDetector(
        onTap: () {
          detailTools(context, itemIndex);
        },
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [defaultShadow],
              color: tools.stok_akhir != '0' ? mainColor : Colors.grey[400],
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
                      border: Border.all(
                          width: 1.4,
                          color: tools.stok_akhir != '0'
                              ? mainColor
                              : Colors.grey[400]),
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image(
                      image: tools.image_tools != ""
                          ? NetworkImage(link + "/img/" + tools.image_tools)
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
                    color:
                        tools.stok_akhir != '0' ? mainColor : Colors.grey[400],
                    fontWeight: FontWeight.w600,
                  ),
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
                      color: tools.stok_akhir != '0'
                          ? mainColor
                          : Colors.grey[400],
                      height: 2,
                      fontSize: 13.5),
                ),
                Text(
                  "${tools.lokasi_tools}",
                  style: TextStyle(
                      color: Colors.grey[400], height: 2, fontSize: 13.5),
                ),
              ]),
            ),
          )
        ]),
      ),
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
                      isSelected = true;
                      selectedIndex = index;
                      toolsArray = toolsObj.where((element) {
                        var lokasiTools = element.lokasi_tools;
                        return lokasiTools.contains(lokasi[index]);
                      }).toList();
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
                        color: isSelected == false
                            ? Colors.transparent
                            : index == selectedIndex
                                ? mainColor.withOpacity(0.1)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      lokasi[index],
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 13,
                          fontWeight: isSelected == false
                              ? FontWeight.normal
                              : index == selectedIndex
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
        onChanged: (text) {
          setState(() {
            toolsArray = toolsObj.where((element) {
              var namaTools = element.nama_tools.toLowerCase();
              return namaTools.contains(text);
            }).toList();
          });
        },
        style: TextStyle(color: mainColor),
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            alignLabelWithHint: true,
            focusedBorder: InputBorder.none,
            hintText: 'Pinjam Alat?',
            hintStyle: TextStyle(
              fontSize: 14,
              color: mainColor,
            ),
            icon: Icon(
              Icons.search,
              color: mainColor,
            )),
      ),
    );
  }

  detailTools(BuildContext context, int index) {
    tools = toolsArray[index];
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(top: 200),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(bottom: 150),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        child: Image(
                          image: tools.image_tools != ''
                              ? NetworkImage(link + "/img/${tools.image_tools}")
                              : AssetImage("images/svg/placeIMG.png"),
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 270),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: defaultPadding - 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  color: mainColor,
                                  size: 17,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    tools.lokasi_tools,
                                    style: TextStyle(
                                        color: mainColor, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: defaultPadding),
                            child: Text(
                              "${tools.merk} ${tools.type} - ${tools.nama_tools}",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: mainColor,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin:
                                EdgeInsets.only(top: 0, bottom: defaultPadding),
                            child: Text(
                                "${tools.stok_akhir}/${tools.stok_awal} ${tools.satuan} • ${tools.desk_tools} • ${tools.thn_masuk} • ${tools.bahan}"),
                          ),
                          Divider(
                            color: Colors.black54.withOpacity(0.15),
                            height: 0,
                            thickness: 0.5,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: defaultPadding,
                                  bottom: defaultPadding / 5),
                              child: Text(
                                "Deskripsi",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: mainColor),
                              )),
                          Text(tools.spesifikasi),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 4.5,
                                vertical: 20),
                            child: RaisedButton(
                                color: mainColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                disabledColor: Colors.grey[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                onPressed:
                                    tools.stok_akhir == '0' ? null : scan,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      FontAwesome5.qrcode,
                                      size: 18,
                                      color: tools.stok_akhir != '0'
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                    Text(
                                      "Pindai Alat",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: tools.stok_akhir != '0'
                                              ? Colors.white
                                              : Colors.black54),
                                    )
                                  ],
                                )),
                          )
                        ]),
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(
                        top: defaultPadding * 1.5,
                      ),
                      child: RaisedButton(
                        color: mainColor,
                        padding: EdgeInsets.all(10),
                        shape: CircleBorder(
                            side: BorderSide(width: 4, color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context, index);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
