import 'package:deneme/ui/mainPageScreen.dart';
import 'package:flutter/material.dart';
import 'sorularOncesi.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          SizedBox(height: 30),
          Text(
            "Evde sigara u?llanır mısınız",
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
            height: 25,
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
            height: 25,
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
          Center(
            child: RaisedButton(
              onPressed: () {
                _ozellikEkle();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
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
                child: const Text('Devam Et ', style: TextStyle(fontSize: 20)),
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


    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      _firestore
          .collection('kullanicilar')
          .document("$uid")
          .collection("ozellikler")
          .document("ozellik")
          .setData(ozellik,merge: true);
    }
  }
}
