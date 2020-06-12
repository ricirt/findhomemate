import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/Classes/kisi.dart';
import 'package:deneme/ui/ilanDetay.dart';
import 'package:deneme/ui/ilanVer.dart';
import 'package:deneme/ui/kullaniciDetay.dart';
import 'package:deneme/ui/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:core';
import 'package:deneme/Classes/notificationHandler.dart';

bool loading = true;

class Anasayfa extends StatefulWidget {
  @override
  AnasayfaState createState() {
    return new AnasayfaState();
  }
}

List<Kisi> kisiList;

class AnasayfaState extends State<Anasayfa>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;
  String userid;
  String adSoyad;
  String profilResmi;
  String ilanSahibiID;
  String mesaj = "";
  bool evSahibimi;
  TabController tabController;
  @override
  void initState() {
    super.initState();
    debugPrint("başlıyorr");
    NotificationHandler().initializeFCMNotification(context);
    _getID();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.blue,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    tabs: [Icon(Icons.home), Icon(Icons.people)],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[homePage(), homePageKisi()],
        ),
      ),
    );
  }

  Widget homePage() {
    bool ilan = true;
    loading = false;
    return loading
        ? Loading()
        : Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Uygun Ev ilanları ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Visibility(
                          visible: evSahibimi == true ? ilan : false,
                          replacement: Text(""),
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return IlanVer();
                              }));
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    child: StreamBuilder(
                        stream: Firestore.instance.collection('ev').snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView(
                            children: snapshot.data.documents
                                .map((doc) => Card(
                                      child: InkWell(
                                        child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          child: Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Stack(children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    height: 140,
                                                    child: FadeInImage.assetNetwork(
                                                        alignment:
                                                            Alignment.center,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            "assets/loading.gif",
                                                        image: doc['url']
                                                            .toString()),
                                                  ),
                                                ]),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          doc['konum']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "\$ ${doc['fiyat'].toString()}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return IlanDetay(
                                              ilanSahibiUserID: doc['uid'],
                                            );
                                          }));
                                        },
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
  }

  Widget homePageKisi() {
    return loading
        ? Loading()
        : Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child:Column(
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
                              image: NetworkImage(profilResmi == null ? "" : profilResmi),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            adSoyad.toString(),
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
                Divider(indent: 5,color: Colors.black,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Ev Arayan Kullanıcılar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Divider(indent: 5,),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('kullanicilar')
                            .where("evSahibi", isEqualTo: false)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView(
                            children: snapshot.data.documents
                                .map((doc) => Card(
                                      child: InkWell(
                                        child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          child: Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Stack(children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    height: 150,
                                                    child: FadeInImage.assetNetwork(
                                                        alignment:
                                                            Alignment.center,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            "assets/loading.gif",
                                                        image:
                                                            doc['profilResmi']
                                                                .toString()),
                                                  ),
                                                ]),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      doc['adSoyad'].toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          doc['konum'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return KullaniciDetay(
                                              kullaniciID: doc['uid'],
                                            );
                                          }));
                                        },
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                  ),
                ),
              ],
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

  Future _getID() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid").get();

      setState(() {
        userid = documentSnapshot.data['uid'].toString();
        adSoyad = documentSnapshot.data['adSoyad'].toString();
        evSahibimi = documentSnapshot.data['evSahibi'];
        profilResmi = documentSnapshot.data['profilResmi'].toString();
      });
    }
    loading = false;
  }
}
