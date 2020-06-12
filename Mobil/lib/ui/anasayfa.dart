import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/Classes/kisi.dart';
import 'package:deneme/ui/ilanDetay.dart';
import 'package:deneme/ui/ilanVer.dart';
import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/profile.dart';
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

  List<String> uidList = List();
  List<String> urlList = List();
  List<String> fiyatList = List();
  List<String> konumList = List();
  String userid;

  String ilanSahibiID;

  String mesaj = "";
  int itemSayisi = 1;
  TabController tabController;
  @override
  void initState() {
    super.initState();
    debugPrint("başlıyorr");
    NotificationHandler().initializeFCMNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homePage(),
    );
  }

  Widget homePage() {
    bool ilan = false;
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
                          visible: kisi.evSahibimi == false ? ilan : true,
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
}
