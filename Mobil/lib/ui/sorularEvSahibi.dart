import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/mainPageScreen.dart';
import 'package:deneme/ui/sorularEv.dart';
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
            body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Sorular",
                  style: TextStyle(
                    fontSize: 36,
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
                SizedBox(height: 40),
                Text(
                  "Evde sigara içilmesi sizin için sorun olur mu?",
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
                SizedBox(height: 40),
                Text(
                  "Evde Alkol içilmesi sizin için sorun olur mu?",
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
                      height: 10,
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
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      _ozellikEkle();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MainPageScreen();
                      }));
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Devam Et ',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
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
