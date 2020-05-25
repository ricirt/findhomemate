import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/ui/ilanDetay.dart';
import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

bool loading = true;

class Anasayfa extends StatefulWidget {
  @override
  AnasayfaState createState() {
    return new AnasayfaState();
  }
}


class AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: homePage());
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;
  String mesaj = "";
  int itemSayisi = 1;

  Widget homePage() {
    return loading
        ? Loading()
        : Container(
            margin: EdgeInsets.only(top: 35, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://pbs.twimg.com/profile_images/1197914578958651392/goaSDVjl_400x400.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            kisi.adSoyad,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          //*************************//////Exit BUTONU ***************************
                          onTap: () {
                            _cikisYap();
                          },
                          child: Row(
                            children: <Widget>[
                              Text("Çıkış Yap",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Icon(Icons.exit_to_app),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Uygun Ev ilanları ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext ctxt, int index) =>
                            _anasayfaGrid(ctxt, index)),
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildBody(BuildContext ctxt, int index) {
    return new Text(litems[index]);
  }

  List<String> litems = ["1", "2", "Third", "4"];

  Widget _anasayfaGrid(BuildContext ctxt, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return IlanDetay();
        }));
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: Container(
          width: double.infinity,
          height: 200,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                child: FadeInImage.assetNetwork(
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    placeholder: "assets/loading.gif",
                    image:
                        "http://www.kocerdemyapi.com/wp-content/uploads/2018/09/dMhgct-house-png-home-background-1.png"),
              ),
              Positioned(
                right: 1,
                bottom: 10,
                child: FloatingActionButton(
                  heroTag: null,
                  mini: true,
                  onPressed: () {},
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //crossAxisAlignment:

                    Text(
                      "Aile evi",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Eskişehir,Büyükdere",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _cikisYap() async {
    if (await _auth.currentUser() != null) {
      _auth.signOut().then((data) {
        setState(() {});
        _googleAuth.signOut();
        loading = true;
        Navigator.pushNamed(context, "/loginScreen");
      }).catchError((hata) {
        mesaj += "\nÇıkış yaparken hata oluştu $hata";
      });
    } else {
      mesaj += "\nOturum açmış kullanıcı yok";
    }

    setState(() {});
  }

  Future _getInfo() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;
    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid").get();

      setState(() {
        kisi.adSoyad = documentSnapshot.data['adSoyad'].toString();
      });
    }
    setState(() {
      loading = false;
    });
  }
}
