import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/ui/mainPageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class IlanVer extends StatefulWidget {
  @override
  _IlanVerState createState() => _IlanVerState();
}

class _IlanVerState extends State<IlanVer> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File _secilenResim;

  bool radioWifi;
  bool radioTv;
  bool radioDepozito;
  bool radioFatura;
  bool radioEsya;
  bool radioGaraj;
  bool radioDogalgaz;

  final _fiyatController = TextEditingController();
  final _odaController = TextEditingController();
  final _katController = TextEditingController();
  final _konumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: _secilenResim == null
                          ? Text("Resim Seçilmedi")
                          : Image.file(_secilenResim),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("Galeriden Resim Yukle"),
                  color: Colors.blueAccent,
                  onPressed: _galeriResim,
                ),
                RaisedButton(
                  child: Text("Kameradan Resim Yukle"),
                  color: Colors.blueAccent,
                  onPressed: _kameraResim,
                ),
                TextFormField(
                  controller: _fiyatController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on),
                    hintText: "Fiyat",
                  ),
                ),
                TextFormField(
                  controller: _odaController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home),
                    hintText: "Oda Sayısı",
                  ),
                ),
                TextFormField(
                  controller: _katController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.format_list_numbered_rtl),
                    hintText: "Kat",
                  ),
                ),
                TextFormField(
                  controller: _konumController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    hintText: "Konum",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Text(
            "Evde wifi var mı?",
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
            "Evde TV var mı?",
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
                      groupValue: radioTv,
                      onChanged: (T) {
                        setState(() {
                          radioTv = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: false,
                      groupValue: radioTv,
                      onChanged: (T) {
                        setState(() {
                          radioTv = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Evin Faturaları ortak mı?",
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
            "Eşyalarınızı paylaşacak mısınız?",
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
            "Garajınız var mı?",
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
            "Doğalgaz var mı?",
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
            "Depozito var mı?",
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
          SizedBox(height: 20),
          Center(
            child: RaisedButton(
              onPressed: () {
                _ozellikEkle();
                Fluttertoast.showToast(
                  msg: "İlan başarıyla tamamlandı",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 2,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
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
                child: const Text('İlan Ver ', style: TextStyle(fontSize: 20)),
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
    var url;

    _firestore
        .collection("kullanicilar")
        .document("$uid")
        .setData({"evSahibi": true}, merge: true);

    String _fiyat = _fiyatController.text;
    String _oda = _odaController.text;
    String _kat = _katController.text;
    String _konum = _konumController.text;

    Map<String, dynamic> ozellik = Map();

    ozellik["fiyat"] = _fiyat.toString();
    ozellik["oda"] = _oda.toString();
    ozellik["kat"] = _kat.toString();
    ozellik["konum"] = _konum.toString();
    ozellik["wifi"] = radioWifi;
    ozellik["tv"] = radioTv;
    ozellik["depozito"] = radioDepozito;
    ozellik["fatura"] = radioFatura;
    ozellik["esya"] = radioEsya;
    ozellik["garaj"] = radioGaraj;
    ozellik["dogalgaz"] = radioDogalgaz;
    ozellik["uid"] = uid.toString();
    ozellik["tarih"] = DateTime.now();

    if (user != null) {
      debugPrint("uid = $uid");
      _firestore
          .collection('ev')
          .document("$uid")
          .setData(ozellik, merge: true);
    }
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("ev")
        .child("$uid")
        .child("ev.png");

    StorageUploadTask uploadTask = ref.putFile(_secilenResim);

    url = await (await uploadTask.onComplete).ref.getDownloadURL();
    debugPrint("resmin url : " + url);

    if (user != null) {
      _firestore
          .collection('ev')
          .document("$uid")
          .setData({"url": url}, merge: true);
    }
  }

  void _galeriResim() async {
    var resim = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim = resim;
    });
  }

  void _kameraResim() async {
    var resim = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _secilenResim = resim;
    });
  }
}
