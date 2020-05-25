import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/Classes/ev.dart';
import 'package:deneme/Classes/evSahibi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:deneme/ui/profile.dart';

Ev ev = Ev();
EvSahibi evSahibi = EvSahibi();

class IlanDetay extends StatefulWidget {
  @override
  _IlanDetayState createState() => _IlanDetayState();
}

class _IlanDetayState extends State<IlanDetay> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    _getHomeInfos();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: screenHeight * 0.6,
            width: double.infinity,
            child: Image.network(
              "http://www.kocerdemyapi.com/wp-content/uploads/2018/09/dMhgct-house-png-home-background-1.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.5),
            height: screenHeight,
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
              child: Container(
                padding: EdgeInsets.only(top: 30, left: 20, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "\$ ${ev.fiyat}",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Text(
                          "kat :${ev.kat}",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Text(
                          "oda : ${ev.oda}",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Icon(Icons.bookmark_border, color: Colors.purple),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.purple.shade200,
                          child: Text(
                            "Mesaj at ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (buildContext) {
                                return ProfilePage();
                              }));
                            });
                          },
                          color: Colors.purple.shade200,
                          child: Text(
                            "${kisi.adSoyad}'in Profiline git ",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Sigara",
                              style: _style(),
                            ),
                            Icon(evSahibi.sigara == true
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
                            Icon(evSahibi.alkol == true
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
                            Icon(evSahibi.evcilHayvan == true
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
                              "Cinsiyet",
                              style: _style(),
                            ),
                            Icon(evSahibi.cinsiyet == true
                                ? Icons.pregnant_woman
                                : Icons.accessibility_new),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Garaj",
                              style: _style(),
                            ),
                            Icon(ev.garaj == true ? Icons.check : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Wifi",
                              style: _style(),
                            ),
                            Icon(ev.wifi == true ? Icons.check : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "TV",
                              style: _style(),
                            ),
                            Icon(ev.tv == true ? Icons.check : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Fatura ortaklığı",
                              style: _style(),
                            ),
                            Icon(
                                ev.fatura == true ? Icons.check : Icons.cancel),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Doğalgaz",
                              style: _style(),
                            ),
                            Icon(ev.dogalgaz == true
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
                              "Eşya",
                              style: _style(),
                            ),
                            Icon(ev.esya == true ? Icons.check : Icons.cancel),
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
                            Icon(
                              evSahibi.misafir == true
                                  ? Icons.check
                                  : Icons.cancel,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Depozito",
                              style: _style(),
                            ),
                            Icon(ev.depozito == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  Future _getHomeInfos() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid/ev/ozellik").get();


      setState(() {
        ev.depozito = documentSnapshot.data['depozito'];
        ev.dogalgaz = documentSnapshot.data['dogalgaz'];
        ev.esya = documentSnapshot.data['esya'];
        ev.fatura = documentSnapshot.data['fatura'];
        ev.fiyat = documentSnapshot.data['fiyat'].toString();
        ev.garaj = documentSnapshot.data['garaj'];
        ev.kat = documentSnapshot.data['kat'].toString();
        ev.oda = documentSnapshot.data['oda'].toString();
        ev.tv = documentSnapshot.data['tv'];
        ev.wifi = documentSnapshot.data['wifi'];
      });

      if (user != null) {
        DocumentSnapshot documentSnapshot = await _firestore
            .document("kullanicilar/$uid/kullanici/ozellik")
            .get();

        setState(() {
          evSahibi.alkol = documentSnapshot.data['alkol'];
          evSahibi.sigara = documentSnapshot.data['sigara'];
          evSahibi.cinsiyet = documentSnapshot.data['cinsiyet'];
          evSahibi.evcilHayvan = documentSnapshot.data['hayvan'];
          evSahibi.misafir = documentSnapshot.data['misafir'];
        });
      }
    }
  }
}
