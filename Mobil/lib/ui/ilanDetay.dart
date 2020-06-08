import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/Classes/ev.dart';
import 'package:deneme/Classes/evSahibi.dart';
import 'package:deneme/Classes/evSahibiNitelikleri.dart';
import 'package:deneme/ui/evSahibiProfil.dart';
import 'package:deneme/ui/mesajlar.dart';
import 'package:flutter/material.dart';

/*future : kullanicilariGetir()
    builder : (context,snpashot){
      if(snapshot.ConnectionState == ConnectionState.waiting) {
        return Center(chil)
      }
    }*/

Ev ev = Ev();
//EvSahibi evSahibi = EvSahibi();
EvSahibiNitelikleri evSahibiNitelikleri = EvSahibiNitelikleri();
int yas, puan, oylayan;
double sonuc;

class IlanDetay extends StatefulWidget {
  @override
  _IlanDetayState createState() => _IlanDetayState();
  String ilanSahibiUserID;

  IlanDetay({this.ilanSahibiUserID});
}

class _IlanDetayState extends State<IlanDetay> {
  final Firestore _firestore = Firestore.instance;

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

  @override
  void initState() {
    super.initState();
    debugPrint("gelen id : " + widget.ilanSahibiUserID.toString());
    gelenId = widget.ilanSahibiUserID;
    _getHomeInfos();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: screenHeight * 0.6,
            width: double.infinity,
            child: FadeInImage.assetNetwork(
                alignment: Alignment.center,
                fit: BoxFit.cover,
                placeholder: "assets/loading.gif",
                image: ev.url),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.5),
            height: screenHeight,
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
              child: Container(
                padding: EdgeInsets.only(top: 30, left: 20, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "\$ ${ev.fiyat}",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Text(
                          "kat :${ev.kat}",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Text(
                          "oda : ${ev.oda}",
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
                             Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (buildContext) => Mesajlar(),
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
                                  builder: (buildContext) => EvSahibiProfile(
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
                            Icon(evSahibiNitelikleri.sigara == true
                                ? Icons.check
                                : Icons.cancel),
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
                            Icon(evSahibiNitelikleri.alkol == true
                                ? Icons.check
                                : Icons.cancel),
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
                            Icon(evSahibiNitelikleri.evcilHayvan == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Cinsiyet",
                              style: _style(),
                            ),
                            Icon(evSahibiNitelikleri.cinsiyetTercih == true
                                ? Icons.pregnant_woman
                                : Icons.accessibility_new),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Garaj",
                              style: _style(),
                            ),
                            Icon(ev.garaj == true ? Icons.check : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Wifi",
                              style: _style(),
                            ),
                            Icon(ev.wifi == true ? Icons.check : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "TV",
                              style: _style(),
                            ),
                            Icon(ev.tv == true ? Icons.check : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Fatura ortaklığı",
                              style: _style(),
                            ),
                            Icon(
                                ev.fatura == true ? Icons.check : Icons.cancel),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Doğalgaz",
                              style: _style(),
                            ),
                            Icon(ev.dogalgaz == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Eşya",
                              style: _style(),
                            ),
                            Icon(ev.esya == true ? Icons.check : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Misafir",
                              style: _style(),
                            ),
                            Icon(
                              evSahibiNitelikleri.misafir == true
                                  ? Icons.check
                                  : Icons.cancel,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Depozito",
                              style: _style(),
                            ),
                            Icon(ev.depozito == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
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

  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  Future _getHomeInfos() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.document("kullanicilar/$gelenId/ev/ozellik").get();

    setState(() {
      ev.depozito = documentSnapshot.data['depozito'];
      ev.dogalgaz = documentSnapshot.data['dogalgaz'];
      ev.esya = documentSnapshot.data['esya'];
      ev.fatura = documentSnapshot.data['fatura'];
      ev.fiyat = documentSnapshot.data['fiyat'].toString();
      ev.garaj = documentSnapshot.data['garaj'];
      ev.kat = documentSnapshot.data['kat'].toString();
      ev.oda = documentSnapshot.data['oda'].toString();
      ev.tv = documentSnapshot.data['tv'];
      ev.wifi = documentSnapshot.data['wifi'];
      ev.url = documentSnapshot.data['url'];
    });

    DocumentSnapshot documentSnapshot2 = await _firestore
        .document("kullanicilar/$gelenId/kullanici/ozellik")
        .get();

    setState(() {
      evSahibiNitelikleri.alkol = documentSnapshot2.data['alkol'];
      evSahibiNitelikleri.sigara = documentSnapshot2.data['sigara'];
      evSahibiNitelikleri.cinsiyetTercih =
          documentSnapshot2.data['cinsiyetTercih'];
      evSahibiNitelikleri.evcilHayvan = documentSnapshot2.data['hayvan'];
      evSahibiNitelikleri.misafir = documentSnapshot2.data['misafir'];
    });

    debugPrint(evSahibiNitelikleri.alkol.toString());
    debugPrint(evSahibiNitelikleri.sigara.toString());
    debugPrint(evSahibiNitelikleri.cinsiyetTercih.toString());
    debugPrint(evSahibiNitelikleri.evcilHayvan.toString());
    debugPrint(evSahibiNitelikleri.misafir.toString());

    DocumentSnapshot documentSnapshot3 =
        await _firestore.document("kullanicilar/$gelenId").get();

    setState(() {
      adSoyad = documentSnapshot3.data['adSoyad'];
      cinsiyet = documentSnapshot3.data['cinsiyet'];
      email = documentSnapshot3.data['email'];
      meslek = documentSnapshot3.data['meslek'];
      oylayan = documentSnapshot3.data['oylayan'];
      profilResmi = documentSnapshot3.data['profilResmi'];
      puan = documentSnapshot3.data['puan'];
      yas = documentSnapshot3.data['dogumYili'];
      //uid = documentSnapshot3.data['uid'];
      //yas = int.parse(evSahibi.yas);
      //yas = 2020 - yas;
      // evSahibi.yas = yas.toString();
      //debugPrint("yasssss : " + evSahibi.yas);
    });
    /*debugPrint(evSahibi.adSoyad.toString());
    debugPrint(evSahibi.cinsiyet.toString());
    debugPrint(evSahibi.email.toString());
    debugPrint(evSahibi.oylayan.toString());
    debugPrint(evSahibi.profilResmi.toString());
    debugPrint(evSahibi.puan.toString());
    debugPrint(evSahibi.yas.toString());
    debugPrint(evSahibi.uid.toString());*/
  }
}
