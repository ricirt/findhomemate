import 'package:deneme/Widgets/evFeatures.dart';
import 'package:deneme/Widgets/kisiFeatures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Kisi kisi = Kisi();
KisiNitelikler kisiNitelikler = KisiNitelikler();
int yas, puan, oylayan;
double sonuc;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getInfo();
    _getFeatures();

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }

  void _getInfo() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid").get();

      setState(() {
        kisi.adSoyad = documentSnapshot.data['adSoyad'].toString();
        kisi.email = documentSnapshot.data['email'].toString();
        kisi.yas = documentSnapshot.data['dogumYili'].toString();
        kisi.meslek = documentSnapshot.data['meslek'].toString();
        kisi.puan = documentSnapshot.data['puan'].toString();
        kisi.oylayan = documentSnapshot.data['oylayan'].toString();
        kisi.cinsiyet = documentSnapshot.data['cinsiyet'].toString();

        yas = int.parse(kisi.yas);
        yas = 2020 - yas;
        puan = int.parse(kisi.puan);

        oylayan = int.parse(kisi.oylayan);
        sonuc = puan / oylayan;
      });
    }
  }

  void _getFeatures() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot = await _firestore
          .document("kullanicilar/$uid/ozellikler/ozellik")
          .get();

      setState(() {
        kisiNitelikler.alkol = documentSnapshot.data['alkol'];
        kisiNitelikler.evcilHayvan = documentSnapshot.data['hayvan'];
        kisiNitelikler.misafir = documentSnapshot.data['misafir'];
        kisiNitelikler.sigara = documentSnapshot.data['sigara'];
      });
    }
  }
}

class ProfilePage extends StatelessWidget {
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
              Text(kisi.email),
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
              Text(kisi.meslek),
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
              Text(kisi.cinsiyet),
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
                      Icon(kisiNitelikler.sigara == true
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
                        "Alkol",
                        style: _style(),
                      ),
                      Icon(kisiNitelikler.alkol == true
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
                        style: _style(),
                      ),
                      Icon(kisiNitelikler.evcilHayvan == true
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
                        "Cinsiyet",
                        style: _style(),
                      ),
                      /*Icon(Profilozellik[0].cinsiyet == true
                          ? Icons.pregnant_woman
                          : Icons.face),*/
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
                      Icon(kisiNitelikler.misafir == true
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
}

final String url =
    "https://pbs.twimg.com/profile_images/1197914578958651392/goaSDVjl_400x400.jpg";

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
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(url))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      kisi.adSoyad,
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
                      "$sonuc/5",
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
                      kisi.oylayan.toString(),
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
