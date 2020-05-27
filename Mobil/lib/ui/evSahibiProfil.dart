import 'package:deneme/Classes/evSahibi.dart';
import 'package:deneme/Classes/evSahibiNitelikleri.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';



EvSahibi evSahibi = EvSahibi();
EvSahibiNitelikleri evSahibiNitelikleri = EvSahibiNitelikleri();
int yas, puan, oylayan;
double sonuc;

class EvSahibiProfile extends StatefulWidget {
  @override
  _EvSahibiProfileState createState() => _EvSahibiProfileState();
}

class _EvSahibiProfileState extends State<EvSahibiProfile> {
  final Firestore _firestore = Firestore.instance;
  @override
  void initState() {
    super.initState();
    debugPrint("başla");
    _getInfos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: EvSahibiProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }

  Future _getInfos() async {
    

    DocumentSnapshot documentSnapshot2 = await _firestore
        .document("kullanicilar/${evSahibi.uid}/kullanici/ozellik")
        .get();

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

    DocumentSnapshot documentSnapshot3 =
        await _firestore.document("kullanicilar/${evSahibi.uid}").get();

    setState(() {
      evSahibi.adSoyad = documentSnapshot3.data['adSoyad'];
      evSahibi.cinsiyet = documentSnapshot3.data['cinsiyet'];
      evSahibi.email = documentSnapshot3.data['email'];
      evSahibi.meslek = documentSnapshot3.data['meslek'];
      evSahibi.oylayan = documentSnapshot3.data['oylayan'];
      evSahibi.profilResmi = documentSnapshot3.data['profilResmi'];
      evSahibi.puan = documentSnapshot3.data['puan'];
      evSahibi.yas = documentSnapshot3.data['dogumYili'];
      evSahibi.uid = documentSnapshot3.data['uid'];
      yas = int.parse(evSahibi.yas);
      yas = 2020 - yas;
      evSahibi.yas = yas.toString();
      debugPrint("yasssss : " + evSahibi.yas);
    });
    debugPrint(evSahibi.adSoyad.toString());
    debugPrint(evSahibi.cinsiyet.toString());
    debugPrint(evSahibi.email.toString());
    debugPrint(evSahibi.oylayan.toString());
    debugPrint(evSahibi.profilResmi.toString());
    debugPrint(evSahibi.puan.toString());
    debugPrint(evSahibi.yas.toString());
    debugPrint(evSahibi.uid.toString());

     debugPrint("fatih");
  }

 
}

class EvSahibiProfilePage extends StatelessWidget {
  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Text(
                "Email",
                style: _style(),
              ),
              SizedBox(
                height: 4,
              ),
              Text(evSahibi.email.toString()),
              SizedBox(
                height: 16,
              ),
              Text(
                "Konum",
                style: _style(),
              ),
              SizedBox(
                height: 4,
              ),
              Text("Büyükdere, Eskişehir"),
              SizedBox(
                height: 16,
              ),
              Text(
                "Meslek",
                style: _style(),
              ),
              SizedBox(
                height: 4,
              ),
              Text(evSahibi.meslek.toString()),
              SizedBox(
                height: 16,
              ),
              Text(
                "Cinsiyet",
                style: _style(),
              ),
              SizedBox(
                height: 4,
              ),
              Text(""),
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
                        style: _style(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Alkol",
                        style: _style(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Evcil Hayvan",
                        style: _style(),
                      ),
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
                        style: _style(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Misafir",
                        style: _style(),
                      ),
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
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);

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
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://pbs.twimg.com/profile_images/1197914578958651392/goaSDVjl_400x400.jpg"))),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "",
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
                      "",
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
                      "",
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
                      "",
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
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/editProfile");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
                  child: Transform.rotate(
                    angle: (math.pi * 0.05),
                    child: Container(
                      width: 110,
                      height: 32,
                      child: Center(
                        child: Text("Profili Düzenle"),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 20)
                          ]),
                    ),
                  ),
                ),
              ),
            )
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
