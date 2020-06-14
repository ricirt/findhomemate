import 'package:deneme/ui/sorularEvSahibi.dart';
import 'package:deneme/ui/sorularKisi.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            SizedBox(height: 100),
            Text(
              "Ev mi, Arkadaş mı Arıyorsun ?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: selectedRadio,
                        value: 1,
                        onChanged: (val) {
                          setSelectedRadio(val);
                        },
                      ),
                      Text(
                        "Ev arıyorum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: selectedRadio,
                        value: 2,
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
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Center(
                      child: RaisedButton(
                        onPressed: () {
                          _yonlendir();
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
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
    if (selectedRadio == 2) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return SorularEvSahibi();
      }));
    } else if (selectedRadio == 1) {
      _firestore
          .collection("kullanicilar")
          .document("$uid")
          .setData({"evSahibi": false}, merge: true);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return SorularKisi();
      }));
    } else {
      Fluttertoast.showToast(
        msg: "Lütfen bir seçim yapın",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
