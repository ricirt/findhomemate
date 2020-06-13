import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/Classes/ev.dart';
import 'package:deneme/Classes/evSahibi.dart';
import 'package:deneme/Classes/evSahibiNitelikleri.dart';
import 'package:deneme/ui/evSahibiProfil.dart';
import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/mesajlarDetay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool loading;
Ev ev = Ev();
EvSahibiNitelikleri evSahibiNitelikleri = EvSahibiNitelikleri();
int yas, puan, oylayan;
double sonuc;

class KullaniciDetay extends StatefulWidget {
  @override
  _KullaniciDetayState createState() => _KullaniciDetayState();
  String kullaniciID;

  KullaniciDetay({this.kullaniciID});
}

class _KullaniciDetayState extends State<KullaniciDetay> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String adSoyad;
  String cinsiyet;
  String email;
  String meslek;
  String oylayan;
  String profilResmi;
  String puan;
  String yas;
  String uid;
  String gelenId;
  String userid;
  String konum;
  bool alkol;
  bool sigara;
  bool misafir;
  bool evcilHayvan;
  bool cinsiyetTercih;

  @override
  void initState() {
    super.initState();
    debugPrint("gelen id : " + widget.kullaniciID.toString());
    gelenId = widget.kullaniciID;
    _forid();
    _getInfos();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    loading = false;
    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  height: screenHeight * 0.6,
                  width: double.infinity,
                  child: FadeInImage.assetNetwork(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      placeholder: "assets/loading.gif",
                      image: profilResmi == null
                          ? "assets/loading.gif"
                          : profilResmi),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.5),
                  height: screenHeight,
                  width: double.infinity,
                  child: Material(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80)),
                    child: Container(
                      padding: EdgeInsets.only(top: 30, left: 20, bottom: 30),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                adSoyad.toString(),
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Text(
                                konum.toString(),
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
                                onPressed: () {
                                  loading = true;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (buildContext) => MesajDetay(
                                        conversationid: userid,
                                        aliciID: gelenId,
                                      ),
                                    ),
                                  );
                                },
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
                                      MaterialPageRoute(
                                        builder: (buildContext) =>
                                            EvSahibiProfile(
                                          EvSahibi(
                                              adSoyad: adSoyad,
                                              cinsiyet: cinsiyet,
                                              email: email,
                                              meslek: meslek,
                                              oylayan: oylayan,
                                              profilResmi: profilResmi,
                                              puan: puan,
                                              uid: gelenId,
                                              yas: yas),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                color: Colors.purple.shade200,
                                child: Text(
                                  "$adSoyad profiline git",
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
                                  sigara == true ? green() : red(),
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
                                  alkol == true ? green() : red(),
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
                                  evcilHayvan == true ? green() : red(),
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
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Misafir",
                                    style: _style(),
                                  ),
                                  misafir == true ? green() : red()
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Cinsiyet Tercihi",
                                    style: _style(),
                                  ),
                                  Icon(cinsiyetTercih == true
                                      ? Icons.pregnant_woman
                                      : Icons.accessibility_new),
                                ],
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

  Widget green() {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Widget red() {
    return Icon(
      Icons.cancel,
      color: Colors.red,
    );
  }

  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  void _forid() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid").get();

      setState(() {
        userid = documentSnapshot.data['uid'].toString();
        print("userid : " + userid.toString());
      });
    }
  }

  Future _getInfos() async {
    DocumentSnapshot documentSnapshot2 = await _firestore
        .document("kullanicilar/$gelenId/kullanici/ozellik")
        .get();

    setState(() {
      alkol = documentSnapshot2.data['alkol'];
      sigara = documentSnapshot2.data['sigara'];
      cinsiyetTercih = documentSnapshot2.data['cinsiyetTercih'];
      evcilHayvan = documentSnapshot2.data['hayvan'];
      misafir = documentSnapshot2.data['misafir'];
      if (alkol == true) {}

      print("alkol : " + alkol.toString());
      print("sigara : " + sigara.toString());
      print("cinsiyetTercih : " + cinsiyetTercih.toString());
      print("evcilHayvan : " + evcilHayvan.toString());
      print("misafir : " + misafir.toString());
    });

    DocumentSnapshot documentSnapshot3 =
        await _firestore.document("kullanicilar/$gelenId").get();

    setState(() {
      adSoyad = documentSnapshot3.data['adSoyad'];
      cinsiyet = documentSnapshot3.data['cinsiyet'];
      email = documentSnapshot3.data['email'];
      meslek = documentSnapshot3.data['meslek'];
      oylayan = documentSnapshot3.data['oylayan'].toString();
      profilResmi = documentSnapshot3.data['profilResmi'];
      puan = documentSnapshot3.data['puan'].toString();
      yas = documentSnapshot3.data['dogumYili'];
      konum = documentSnapshot3.data['konum'];
      print("adSoyad : " + adSoyad);
      print("cinsiyet : " + cinsiyet);
      print("email : " + email);
      print("meslek : " + meslek);
      print("oylayan : " + oylayan);
      print("puan : " + puan);
      print("yas : " + yas);
      print("konum : " + konum);
    });
  }
}
