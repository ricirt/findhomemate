import 'package:deneme/Classes/evSahibi.dart';
import 'package:deneme/Classes/evSahibiNitelikleri.dart';
import 'package:deneme/Services/bildirimGondermeServis.dart';
import 'package:deneme/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

//EvSahibi evSahibi = EvSahibi();
String uid;

class EvSahibiProfile extends StatefulWidget {
  final EvSahibi evSahibi;
  EvSahibiProfile(this.evSahibi);

  @override
  _EvSahibiProfileState createState() => _EvSahibiProfileState();
}

class _EvSahibiProfileState extends State<EvSahibiProfile> {
  final Firestore _firestore = Firestore.instance;

  EvSahibiNitelikleri evSahibiNitelikleri = EvSahibiNitelikleri();
  int yas, puan, oylayan;
  double sonuc;
  @override
  void initState() {
    super.initState();
    debugPrint("başla");
    uid = widget.evSahibi.uid;
    _getNitelik();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          widget.evSahibi.profilResmi,
          widget.evSahibi.yas,
          widget.evSahibi.puan,
          widget.evSahibi.oylayan,
          widget.evSahibi.adSoyad,
          widget.evSahibi.uid),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              title('Email'),
              SizedBox(
                height: 4,
              ),
              Text(" ${widget.evSahibi.email}"),
              SizedBox(
                height: 16,
              ),
              title('Durum'),
              SizedBox(
                height: 4,
              ),
              Text("Ev arkadaşı arıyor"),
              SizedBox(
                height: 16,
              ),
              title('Meslek'),
              SizedBox(
                height: 4,
              ),
              Text(" ${widget.evSahibi.meslek}"),
              SizedBox(
                height: 16,
              ),
              title('Cinsiyet'),
              SizedBox(
                height: 4,
              ),
              Text(" ${widget.evSahibi.cinsiyet}"),
              Center(
                child: Text(
                  "Kriterler",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Sigara",
                      ),
                      evSahibiNitelikleri.sigara == true ? green() : red(),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Alkol",
                      ),
                      evSahibiNitelikleri.alkol == true ? green() : red(),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Evcil Hayvan",
                      ),
                      evSahibiNitelikleri.evcilHayvan == true ? green() : red(),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Cinsiyet Tercihi",
                      ),
                      Icon(evSahibiNitelikleri.cinsiyetTercih == true
                          ? Icons.face
                          : Icons.pregnant_woman),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Misafir",
                      ),
                      evSahibiNitelikleri.misafir == true ? green() : red(),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: <Widget>[],
              ),
              Divider(
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget green() {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Widget red() {
    return Icon(
      Icons.cancel,
      color: Colors.red,
    );
  }

  Widget title(String baslik) {
    return Text(
      baslik,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  void _getNitelik() async {
    DocumentSnapshot documentSnapshot2 =
        await _firestore.document("kullanicilar/$uid/kullanici/ozellik").get();

    setState(() {
      evSahibiNitelikleri.alkol = documentSnapshot2.data['alkol'];
      evSahibiNitelikleri.sigara = documentSnapshot2.data['sigara'];
      evSahibiNitelikleri.cinsiyetTercih =
          documentSnapshot2.data['cinsiyetTercih'];
      evSahibiNitelikleri.evcilHayvan = documentSnapshot2.data['hayvan'];
      evSahibiNitelikleri.misafir = documentSnapshot2.data['misafir'];
    });

    debugPrint(evSahibiNitelikleri.alkol.toString());
    debugPrint(evSahibiNitelikleri.sigara.toString());
    debugPrint(evSahibiNitelikleri.cinsiyetTercih.toString());
    debugPrint(evSahibiNitelikleri.evcilHayvan.toString());
    debugPrint(evSahibiNitelikleri.misafir.toString());
  }
}

final List<DropdownMenuItem<int>> listDrop = [];
int point;

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  String resimUrl, yas, puan, oylayan, adSoyad, profilUid;
  CustomAppBar(this.resimUrl, this.yas, this.puan, this.oylayan, this.adSoyad,
      this.profilUid);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, 320);
}

final Firestore _firestore = Firestore.instance;
BildirimGondermServis _bildirimGondermeServis = BildirimGondermServis();

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    loadData();
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 20, offset: Offset(0, 0))
        ]),
        child: Expanded(
          child: Container(
            width: double.infinity,
            height: 400,
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('kullanicilar')
                    .where("uid", isEqualTo: widget.profilUid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data.documents
                        .map((doc) => Card(
                              child: Container(
                                color: Colors.blueAccent,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {},
                                        ),
                                        Text(
                                          "Profile",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            InkWell(
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(doc[
                                                            'profilResmi']))),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              doc['adSoyad'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Yaş",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              doc['dogumYili'],
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "Puan",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                doc['oylayan'] == 0
                                                    ? "0/5"
                                                    : (doc['puan'] /
                                                                doc['oylayan'])
                                                            .round()
                                                            .toString() +
                                                        "/5",
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Oylayan",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              doc['oylayan'].toString(),
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                               
                                    SizedBox(
                                      height: 8,
                                    ),
                                       Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              child: DropdownButton(
                                                elevation:10,
                                                focusColor: Colors.black,
                                                  items: listDrop,
                                                  hint: Text(
                                                    "Puan Ver",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      point = value;
                                                    });
                                                    _puanArtir(point);
                                                  }),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 32,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text("",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24))
                                          ],
                                        ),
                                        SizedBox(
                                          width: 16,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }

  void loadData() {
    listDrop.clear();
    listDrop.add(new DropdownMenuItem(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text("1"),
        Icon(
          Icons.star,
          color: Colors.amber,
        )
      ]),
      value: 1,
    ));
    listDrop.add(new DropdownMenuItem(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text("2"),
        Icon(
          Icons.star,
          color: Colors.amber,
        )
      ]),
      value: 2,
    ));
    listDrop.add(new DropdownMenuItem(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text("3"),
        Icon(
          Icons.star,
          color: Colors.amber,
        )
      ]),
      value: 3,
    ));
    listDrop.add(new DropdownMenuItem(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text("4"),
        Icon(
          Icons.star,
          color: Colors.amber,
        )
      ]),
      value: 4,
    ));
    listDrop.add(new DropdownMenuItem(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text("5"),
        Icon(
          Icons.star,
          color: Colors.amber,
        )
      ]),
      value: 5,
    ));
  }

  void _puanArtir(int point) async {
    _firestore.document("kullanicilar/${widget.profilUid}").updateData({
      "puan": FieldValue.increment(point),
    }).then((v) => debugPrint("puan verilde"));
    print("point : " + point.toString());
    _firestore.document("kullanicilar/${widget.profilUid}").updateData({
      "oylayan": FieldValue.increment(1),
    }).then((v) => debugPrint("oylayann arttı"));

    var token = "";
    token = await tokenGetir(widget.profilUid);
    await _bildirimGondermeServis.bildirimGonderr(
        widget.profilUid, token, kisi.adSoyad);
  }
}

Future<String> tokenGetir(String aliciID) async {
  DocumentSnapshot _token =
      await _firestore.document("tokens/" + aliciID).get();
  if (_token != null)
    return _token.data['token'].toString();
  else
    return null;
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
