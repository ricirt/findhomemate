import 'package:deneme/ui/sorular.dart';
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

  String RadioTercih = "Tercih";
  String RadioEv = "Ev";
  String RadioKisi = "Kisi";
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
                    color: Colors.blue.shade200),
                padding: EdgeInsets.only(left: 10),
                child: Center(
                  child: Text(
                    "Merhaba " +
                        _isim +
                        ", Bizi Tercih Ettiğin İçin Teşekkürler! Şimdi Seni Biraz Tanımak İçin Sorular Soracağiz.Lütfen Soruları eksiksiz Cevaplayın !",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(height: 40),
            Text(
              "TERCİH",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
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

  void _yonlendir() {
    if (selectedRadio == 1) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return Sorular();
      }));
    } else if (selectedRadio == 2) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return SorularKisi();
      }));
    }
  }
}
