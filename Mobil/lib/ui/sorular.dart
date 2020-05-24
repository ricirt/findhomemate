import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/mainPageScreen.dart';
import 'package:flutter/material.dart';
import 'sorularOncesi.dart';
import 'anasayfa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sorular extends StatefulWidget {
  @override
  _SorularState createState() => _SorularState();
}

class _SorularState extends State<Sorular> {
  bool radioHayvan,
      radioSigara,
      radioAlkol,
      radioWifi,
      radiotv,
      radioFatura,
      radioEsya,
      radioCinsiyet,
      radioGaraj,
      radioDogalgaz,
      radioDepozito,
      radioMisafir;
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
                  "Evcil hayvan sizin için sorun olur mu?",
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
                SizedBox(height: 40),
                Text(
                  "Evde WİFİ olmaması sizin için sorun olur mu?",
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
                            groupValue: radioWifi,
                            onChanged: (T) {
                              setState(() {
                                radioWifi = T;
                              });
                            }),
                        Text("Evet"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: false,
                            groupValue: radioWifi,
                            onChanged: (T) {
                              setState(() {
                                radioWifi = T;
                              });
                            }),
                        Text("Hayır"),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Evde TV olmaması sizin için sorun olur mu?",
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
                            groupValue: radiotv,
                            onChanged: (T) {
                              setState(() {
                                radiotv = T;
                              });
                            }),
                        Text("Evet"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: false,
                            groupValue: radiotv,
                            onChanged: (T) {
                              setState(() {
                                radiotv = T;
                              });
                            }),
                        Text("Hayır"),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Evin Faturalarına olmak sizin için sorun olur mu?",
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
                            groupValue: radioFatura,
                            onChanged: (T) {
                              setState(() {
                                radioFatura = T;
                              });
                            }),
                        Text("Evet"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: false,
                            groupValue: radioFatura,
                            onChanged: (T) {
                              setState(() {
                                radioFatura = T;
                              });
                            }),
                        Text("Hayır"),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Eşyalı bir ev mi arıyorsunuz?",
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
                            groupValue: radioEsya,
                            onChanged: (T) {
                              setState(() {
                                radioEsya = T;
                              });
                            }),
                        Text("Evet"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: false,
                            groupValue: radioEsya,
                            onChanged: (T) {
                              setState(() {
                                radioEsya = T;
                              });
                            }),
                        Text("Hayır"),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Evin Garajı olmaması sizin için sorun olur mu?",
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
                            groupValue: radioGaraj,
                            onChanged: (T) {
                              setState(() {
                                radioGaraj = T;
                              });
                            }),
                        Text("Evet"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: false,
                            groupValue: radioGaraj,
                            onChanged: (T) {
                              setState(() {
                                radioGaraj = T;
                              });
                            }),
                        Text("Hayır"),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Evin doğalgaz ısıtması olmaması sizin için sorun olur mu?",
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
                            groupValue: radioDogalgaz,
                            onChanged: (T) {
                              setState(() {
                                radioDogalgaz = T;
                              });
                            }),
                        Text("Evet"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: false,
                            groupValue: radioDogalgaz,
                            onChanged: (T) {
                              setState(() {
                                radioDogalgaz = T;
                              });
                            }),
                        Text("Hayır"),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Ev Depozitosunun olmaması sizin için sorun olur mu?",
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
                            groupValue: radioDepozito,
                            onChanged: (T) {
                              setState(() {
                                radioDepozito = T;
                              });
                            }),
                        Text("Evet"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: false,
                            groupValue: radioDepozito,
                            onChanged: (T) {
                              setState(() {
                                radioDepozito = T;
                              });
                            }),
                        Text("Hayır"),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Eve Misafir yasağı olması için sorun olur mu?",
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
                SizedBox(height: 20),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      _ozellikEkle();
                      loading = true;
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
        .setData({"soruDurum": true},merge: true);

    Map<String, bool> ozellik = Map();

    ozellik["hayvan"] = radioHayvan;
    ozellik["sigara"] = radioSigara;
    ozellik["alkol"] = radioAlkol;
    ozellik["wifi"] = radioWifi;
    ozellik["tv"] = radiotv;
    ozellik["fatura"] = radioFatura;
    ozellik["esya"] = radioEsya;
    ozellik["cinsiyet"] = radioCinsiyet;
    ozellik["garaj"] = radioGaraj;
    ozellik["dogalgaz"] = radioDogalgaz;
    ozellik["depozşto"] = radioDepozito;
    ozellik["misafir"] = radioMisafir;

    if (user != null) {
      debugPrint("uid = $uid");
      _firestore
          .collection('kullanicilar')
          .document("$uid")
          .collection("ozellikler")
          .document("ozellik")
          .setData(ozellik, merge: true);
    }
  }
}
