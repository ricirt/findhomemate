import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/mainPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SorularKisi extends StatefulWidget {
  @override
  _SorularKisiState createState() => _SorularKisiState();
}

class _SorularKisiState extends State<SorularKisi> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool radioHayvan;
  bool radioSigara;
  bool radioAlkol;
  bool radioMisafir;
  bool radioCinsiyetTercih;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Column(
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
                  "Evcil hayvaniniz var mı?",
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
                  "Evde sigara kullanır mısınız",
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Evde Alkol Kullanır mısınız?",
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
                  "Yatılı misafiriniz oluyor mu?",
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
                  "Cinsiyet Tercihiniz ?",
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
                            groupValue: radioCinsiyetTercih,
                            onChanged: (T) {
                              setState(() {
                                radioCinsiyetTercih = T;
                              });
                            }),
                        Text("Kadın"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: false,
                            groupValue: radioCinsiyetTercih,
                            onChanged: (T) {
                              setState(() {
                                radioCinsiyetTercih = T;
                              });
                            }),
                        Text("Erkek"),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top:40),
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {
                        _ozellikEkle();
                        loading = true;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return MainPageScreen();
                        }));
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child:  Text('Devam Et ',
                            style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void _ozellikEkle() async {
    Map<String, bool> ozellik = Map();

    ozellik["hayvan"] = radioHayvan;
    ozellik["sigara"] = radioSigara;
    ozellik["alkol"] = radioAlkol;
    ozellik["misafir"] = radioMisafir;
    ozellik["cinsiyetTercih"] = radioCinsiyetTercih;

    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;
    _firestore
        .collection("kullanicilar")
        .document("$uid")
        .setData({"soruDurum": true}, merge: true);

    if (user != null) {
      _firestore
          .collection('kullanicilar')
          .document("$uid")
          .collection("kullanici")
          .document("ozellik")
          .setData(ozellik, merge: true);
    }
  }
}
