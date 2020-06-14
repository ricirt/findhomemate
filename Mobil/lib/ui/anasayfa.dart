import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/Classes/kisi.dart';
import 'package:deneme/ui/ilanDetay.dart';
import 'package:deneme/ui/ilanVer.dart';
import 'package:deneme/ui/kullaniciDetay.dart';
import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/loginScreen.dart';
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

String ara;

List<Kisi> kisiList;

class AnasayfaState extends State<Anasayfa>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;
  final List<DropdownMenuItem<int>> listDrop = [];
  String userid;
  String ilanSahibiID;
  String mesaj = "";
  int filter;
  int sira;
  int depo;
  TabController tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint("başlıyorr");
    NotificationHandler().initializeFCMNotification(context);
    _getID();
    filter = 2;
  }

  changeFilter(value) {
    setState(() {
      filter = value;
      print("filter fonk :" + filter.toString());
    });
  }

  changeSira(value) {
    setState(() {
      sira = value;
      print("sira :" + sira.toString());
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
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
      ),
    );
  }

  Widget homePage() {
    _loadData();
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
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                depo = 3;
                                changeFilter(3);
                                changeSira(2);
                              },
                            ),
                            hintText: "Aradığınız evin konumunu giriniz...",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: DropdownButton(
                                  items: listDrop,
                                  hint: Text(
                                    "Sırala",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onChanged: (value) {
                                    print("depo :" + depo.toString());
                                    if (depo == 3) {
                                      changeSira(value);
                                    } else {
                                      changeFilter(value);
                                    }
                                  }),
                            ),
                            Visibility(
                              visible: kisi.evSahibimi == false ? ilan : true,
                              replacement: Text(""),
                              child: FloatingActionButton(
                                backgroundColor: Colors.amber,
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
                        stream: filter == 1
                            ? Firestore.instance
                                .collection('ev')
                                .orderBy('fiyat')
                                .snapshots()
                            : filter == 2
                                ? Firestore.instance
                                    .collection('ev')
                                    .orderBy('tarih', descending: true)
                                    .snapshots()
                                : filter == 3 && _searchController.text != "" && sira == 1
                                    ? Firestore.instance
                                        .collection('ev')
                                        .where('konum', isEqualTo: _searchController.text)
                                        .orderBy('fiyat')
                                        .snapshots()
                                    : filter == 3 && _searchController.text != "" && sira == 2
                                        ? Firestore.instance
                                            .collection('ev')
                                            .where('konum', isEqualTo: _searchController.text)
                                            .orderBy('tarih', descending: true)
                                            .snapshots()
                                        : Firestore.instance
                                            .collection('ev')
                                            .orderBy('tarih', descending: true)
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
                              image: NetworkImage(kisi.profilResmi == null
                                  ? ""
                                  : kisi.profilResmi),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            kisi.adSoyad.toString(),
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
                Divider(
                  indent: 5,
                  color: Colors.black,
                ),
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
                Divider(
                  indent: 5,
                ),
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
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
        kisi.adSoyad = documentSnapshot.data['adSoyad'].toString();
        kisi.evSahibimi = documentSnapshot.data['evSahibi'];
        kisi.profilResmi = documentSnapshot.data['profilResmi'].toString();
      });
    }
    loading = false;
  }

  void _loadData() {
    listDrop.clear();
    listDrop.add(new DropdownMenuItem(
      child: new Text("Fiyata göre"),
      value: 1,
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tarihe Göre"),
      value: 2,
    ));
  }
}
