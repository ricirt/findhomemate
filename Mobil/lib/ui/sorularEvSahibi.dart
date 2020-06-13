import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/mainPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SorularEvSahibi extends StatefulWidget {
  @override
  _SorularEvSahibiState createState() => _SorularEvSahibiState();
}

class _SorularEvSahibiState extends State<SorularEvSahibi> {
  bool radioHayvan, radioSigara, radioAlkol, radioCinsiyet, radioMisafir;
  bool loading = false;

  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Lütfen Soruları Eksiksiz Cevaplayınız...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Evcil hayvan kabul eder misiniz?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: true,
                              groupValue: radioHayvan,
                              onChanged: (T) {
                                setState(() {
                                  radioHayvan = T;
                                });
                              }),
                          Text("Evet"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: false,
                              groupValue: radioHayvan,
                              onChanged: (T) {
                                setState(() {
                                  radioHayvan = T;
                                });
                              }),
                          Text("Hayır"),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Evde sigara içilebilir mi?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: true,
                              groupValue: radioSigara,
                              onChanged: (T) {
                                setState(() {
                                  radioSigara = T;
                                });
                              }),
                          Text("Evet"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: false,
                              groupValue: radioSigara,
                              onChanged: (T) {
                                setState(() {
                                  radioSigara = T;
                                });
                              }),
                          Text("Hayır"),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Evde Alkol içilebilir mi?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: true,
                              groupValue: radioAlkol,
                              onChanged: (T) {
                                setState(() {
                                  radioAlkol = T;
                                });
                              }),
                          Text("Evet"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: false,
                              groupValue: radioAlkol,
                              onChanged: (T) {
                                setState(() {
                                  radioAlkol = T;
                                });
                              }),
                          Text("Hayır"),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Evde misafir getirilebilir mi?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: true,
                              groupValue: radioMisafir,
                              onChanged: (T) {
                                setState(() {
                                  radioMisafir = T;
                                });
                              }),
                          Text("Evet"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: false,
                              groupValue: radioMisafir,
                              onChanged: (T) {
                                setState(() {
                                  radioMisafir = T;
                                });
                              }),
                          Text("Hayır"),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Ev arkadaşınızın cinsiyeti ne olmalı?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: true,
                              groupValue: radioCinsiyet,
                              onChanged: (T) {
                                setState(() {
                                  radioCinsiyet = T;
                                });
                              }),
                          Text("Erkek"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: false,
                              groupValue: radioCinsiyet,
                              onChanged: (T) {
                                setState(() {
                                  radioCinsiyet = T;
                                });
                              }),
                          Text("Kadın"),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: RaisedButton(
                        onPressed: () {
                          _ozellikEkle();
                          loading = true;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return MainPageScreen();
                          }));
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child:
                            Text('Devam Et ', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ));
  }

  void _ozellikEkle() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    _firestore
        .collection("kullanicilar")
        .document("$uid")
        .setData({"soruDurum": true}, merge: true);

    Map<String, bool> ozellik = Map();

    ozellik["hayvan"] = radioHayvan;
    ozellik["sigara"] = radioSigara;
    ozellik["alkol"] = radioAlkol;
    ozellik["cinsiyetTercih"] = radioCinsiyet;
    ozellik["misafir"] = radioMisafir;

    if (user != null) {
      debugPrint("uid = $uid");
      _firestore
          .collection('kullanicilar')
          .document("$uid")
          .collection("kullanici")
          .document("ozellik")
          .setData(ozellik, merge: true);
    }
  }
}
