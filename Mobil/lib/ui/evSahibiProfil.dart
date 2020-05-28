import 'package:deneme/Classes/evSahibi.dart';
import 'package:deneme/Classes/evSahibiNitelikleri.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';

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
          widget.evSahibi.adSoyad),
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
              Text(
                "Durum",
              ),
              SizedBox(
                height: 4,
              ),
              Text("Ev arkadaşı arıyor"),
              SizedBox(
                height: 16,
              ),
              Text(
                "Meslek",
              ),
              SizedBox(
                height: 4,
              ),
              Text(" ${widget.evSahibi.meslek}"),
              SizedBox(
                height: 16,
              ),
              Text(
                "Cinsiyet",
              ),
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
                      Icon(evSahibiNitelikleri.sigara == true
                          ? Icons.check
                          : Icons.cancel),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Alkol",
                      ),
                      Icon(evSahibiNitelikleri.alkol == true
                          ? Icons.check
                          : Icons.cancel),
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
                      Icon(evSahibiNitelikleri.evcilHayvan == true
                          ? Icons.check
                          : Icons.cancel),
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
                      Icon(evSahibiNitelikleri.misafir == true
                          ? Icons.check
                          : Icons.cancel),
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

  Widget title(String baslik) {
    return Text(
      baslik,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
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

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);
  String resimUrl, yas, puan, oylayan, adSoyad;
  CustomAppBar(this.resimUrl, this.yas, this.puan, this.oylayan, this.adSoyad);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 20, offset: Offset(0, 0))
        ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(resimUrl))),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      adSoyad,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Yaş",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      yas.toString(),
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Puan",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    Text(
                      puan.toString(),
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Oylayan",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      oylayan.toString(),
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                ),
                SizedBox(
                  width: 32,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text("",
                        style: TextStyle(color: Colors.white, fontSize: 24))
                  ],
                ),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
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
