import 'dart:io';

import 'package:deneme/Classes/kisi.dart';
import 'package:deneme/Classes/kisiNitelikleri.dart';
import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/profiliDuzenle.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
//ses var mıhocam

Kisi kisi = Kisi();
KisiNitelikleri kisiNitelikler = KisiNitelikleri();

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

bool loading = true;
String uid;

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

  Future _getInfo() async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid").get();

      setState(() {
        kisi.adSoyad = documentSnapshot.data['adSoyad'].toString();
        kisi.email = documentSnapshot.data['email'].toString();
        kisi.meslek = documentSnapshot.data['meslek'].toString();
        kisi.cinsiyet = documentSnapshot.data['cinsiyet'].toString();
        kisi.profilResmi = documentSnapshot.data['profilResmi'].toString();
        kisi.evSahibimi = documentSnapshot.data['evSahibi'];
        kisi.uid = documentSnapshot.data['uid'].toString();
        kisi.yas = documentSnapshot.data['dogumYili'].toString();
        kisi.puan = documentSnapshot.data['puan'].toString();
        kisi.oylayan = documentSnapshot.data['oylayan'].toString();
      });
    }
    loading = false;
  }

  Future _getFeatures() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot = await _firestore
          .document("kullanicilar/$uid/kullanici/ozellik")
          .get();

      setState(() {
        kisiNitelikler.alkol = documentSnapshot.data['alkol'];
        kisiNitelikler.evcilHayvan = documentSnapshot.data['hayvan'];
        kisiNitelikler.misafir = documentSnapshot.data['misafir'];
        kisiNitelikler.sigara = documentSnapshot.data['sigara'];
        kisiNitelikler.cinsiyetTercih = documentSnapshot.data['cinsiyetTercih'];
      });
    }
    loading = false;
  }
}

final Firestore _firestore = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

File _secilenResim;

class ProfilePage extends StatelessWidget {
  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                      "Durum",
                      style: _style(),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(kisi.evSahibimi == true
                        ? "Ev arakadaşı arıyor"
                        : "Ev arıyor"),
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
                            kisiNitelikler.sigara == true ? green() : red(),
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
                            kisiNitelikler.alkol == true ? green() : red(),
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
                            kisiNitelikler.evcilHayvan == true
                                ? green()
                                : red(),
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
                            Icon(kisiNitelikler.cinsiyetTercih == true
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
                              style: _style(),
                            ),
                            kisiNitelikler.misafir == true ? green() : red(),
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
        child: Expanded(
          child: Container(
            width: double.infinity,
            height: 400,
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('kullanicilar')
                    .where("uid", isEqualTo: uid)
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
                                              onTap: () {
                                                _resimSec();
                                              },
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
                                        Column(
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24),
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
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return ProfilDuzenle();
                                          }));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 24, 16, 0),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 20)
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
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

  void _resimSec() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;
    var url;

    var resim = await ImagePicker.pickImage(source: ImageSource.gallery);
    _secilenResim = resim;

    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("kullanicilar")
        .child("$uid")
        .child("profil.png");

    StorageUploadTask uploadTask = ref.putFile(_secilenResim);

    url = await (await uploadTask.onComplete).ref.getDownloadURL();
    debugPrint("resmin url : " + url);

    if (user != null) {
      _firestore
          .collection('kullanicilar')
          .document("$uid")
          .setData({"profilResmi": url}, merge: true);
    }
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
