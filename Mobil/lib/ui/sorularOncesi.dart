import 'package:deneme/ui/sorularEvSahibi.dart';
import 'package:deneme/ui/sorularKisi.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SorularOncesi extends StatefulWidget {
  @override
  _SorularOncesiState createState() => _SorularOncesiState();
}

class _SorularOncesiState extends State<SorularOncesi> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var _isim = "";

  int selectedRadio;

  @override
  void initState() {
    super.initState();
    _getData();

    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ev Arkadaşı Bul"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.blue.shade100),
                padding: EdgeInsets.only(left: 10),
                child: Expanded(
                  child: Center(
                    child: Text(
                      "Merhaba " +
                          _isim +
                          ", Bizi Tercih Ettiğin İçin Teşekkürler! Şimdi Seni Biraz Tanımak İçin Sorular Soracağiz.Lütfen Soruları eksiksiz Cevaplayın !",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Nasıl bir arkadaş arıyorsun ?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        ///////////// Evine arkadaş arıyor
                        groupValue: selectedRadio,
                        value: 1,
                        onChanged: (val) {
                          setSelectedRadio(val);
                        },
                      ),
                      Text(
                        "Evime arkadaş arıyorum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        //////////////////////////  kalabileceği bir ev arıyor
                        groupValue: selectedRadio,
                        value: 2,
                        onChanged: (val) {
                          setSelectedRadio(val);
                        },
                      ),
                      Text(
                        "Yanında kalabileceğim ev arkadaşı arıyorum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        _yonlendir();
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
                ],
              ),
            ),
          ],
        )));
  }

  void _getData() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;
    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid").get();
      debugPrint(documentSnapshot.data['adSoyad'].toString());

      setState(() {
        _isim = documentSnapshot.data['adSoyad'].toString();
      });
    }
  }

  void _yonlendir() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (selectedRadio == 1) {
      _firestore
          .collection("kullanicilar")
          .document("$uid")
          .setData({"evSahibi": true}, merge: true);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return SorularEvSahibi();
      }));
    } else if (selectedRadio == 2) {
      _firestore
          .collection("kullanicilar")
          .document("$uid")
          .setData({"evSahibi": false}, merge: true);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return SorularKisi();
      }));
    }
  }
}
