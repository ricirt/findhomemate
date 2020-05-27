import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreIslemleri extends StatefulWidget {
  @override
  _FirestoreIslemleriState createState() => _FirestoreIslemleriState();
}

class _FirestoreIslemleriState extends State<FirestoreIslemleri> {
  final Firestore _firestore = Firestore.instance;
  File _secilenResim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStore Authentication"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Veri Ekle"),
              color: Colors.green,
              onPressed: _veriEkle,
            ),
            RaisedButton(
              child: Text("Transaction"),
              color: Colors.blue,
              onPressed: _transactionEkle,
            ),
            RaisedButton(
              child: Text("Veri sil"),
              color: Colors.red,
              onPressed: _veriSil,
            ),
            RaisedButton(
              child: Text("Veri oku"),
              color: Colors.amber,
              onPressed: _veriOku,
            ),
            RaisedButton(
              child: Text("Veri Sorgula"),
              color: Colors.grey,
              onPressed: _veriSorgula,
            ),
            RaisedButton(
              child: Text("Galeri Resim"),
              color: Colors.grey,
              onPressed: _galeriResim,
            ),
            RaisedButton(
              child: Text("Kamera Resim"),
              color: Colors.grey,
              onPressed: _kameraResim,
            ),
            RaisedButton(
              child: Text(
                "deneme",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              onPressed: _deneme,
            ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: _secilenResim == null
                    ? Text("Resim Yok")
                    : Image.file(_secilenResim),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _veriEkle() {
    Map<String, dynamic> kullaniciEkle = Map();

    // bu yapı her zaman üstüne yazar yani 0dan ekler
    kullaniciEkle["ad"] = "addi";
    kullaniciEkle["ev"] = true;
    kullaniciEkle["ev2"] = true;
    kullaniciEkle["ev3"] = false;
    kullaniciEkle["ev4"] = false;
    //ama 1 tanesini değiştirmek ya da güncellemek için merge kullan
    _firestore
        .collection("kullanicilar")
        .document("yeniKullanici")
        .setData(kullaniciEkle, merge: true)
        .then((v) => debugPrint("kullanici eklendi"));

    // 2. yöntem

    _firestore.collection("kullanicilar").document("yeniKullanici2").setData({
      "ad": "sibel",
      "cinsiyet": "kadın",
      "para": 700
    }).whenComplete(() => debugPrint("kullanici2 eklendi"));

    _firestore.document("/kullanicilar/deniz").setData({"ad": "deniz"});

    //eğer id bilmiyosak sistem kendi atasın istiyosak

    _firestore.collection("kullanicilar").add({"ad": "Fatih", "yas": 35});
    _firestore.collection("kullanicilar").add({"ad": "yasin", "yas": 22});

    String yeniKullaniciID =
        _firestore.collection("kullanicilar").document().documentID;
    debugPrint("doc id :  $yeniKullaniciID");
    _firestore.document("kullanicilar/$yeniKullaniciID").setData({"yas": 30});

    //update için

    _firestore.document("kullanicilar/deniz").updateData({
      "ad": "oya deniz",
      "tarih": FieldValue.serverTimestamp(),
      "oylama sayisi": FieldValue.increment(1),
      "para": 300
    }).then((v) => debugPrint("Kullanıcı Güncellendi"));
  }

  void _transactionEkle() {
    final DocumentReference docRef = _firestore.document("kullanicilar/deniz");

    _firestore.runTransaction((Transaction transaction) async {
      DocumentSnapshot docData = await docRef.get();

      if (docData.exists) {
        var ortadakiPara = docData.data['para'];
        if (ortadakiPara >= 100) {
          await transaction.update(docRef, {"para": ortadakiPara - 100});
          await transaction.update(
              _firestore.document("kullanicilar/yeniKullanici2"),
              {"para": FieldValue.increment(100)});
        } else {
          debugPrint("yetersiz bakiye");
        }
      } else {
        debugPrint("döküman yok");
      }
    });
  }

  void _veriSil() {
    _firestore.document("kullanicilar/yeniKullanici").delete().then((aa) {
      debugPrint("kullanici silindi");
    }).catchError((e) => debugPrint("silerken hata oluştu" + e.toString()));

    _firestore
        .document("kullanicilar/deniz")
        .updateData({"sil": FieldValue.delete()}).then((aa) {
      debugPrint("alan silindi");
    }).catchError((e) => debugPrint("Silerken hata oluştu" + e.toString()));
  }

  Future _veriOku() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.document("kullanicilar/deniz").get();
    debugPrint("döküman id" + documentSnapshot.documentID);
    debugPrint("döküman var mı" + documentSnapshot.exists.toString());
    debugPrint("döküman string" + documentSnapshot.toString());
    debugPrint("döküman bekleyen yazma var mı" +
        documentSnapshot.metadata.hasPendingWrites.toString());
    debugPrint(
        "cacheden mi geldi" + documentSnapshot.metadata.isFromCache.toString());
    debugPrint("cacheden mi geldi" + documentSnapshot.data.toString());
    debugPrint("cacheden mi geldi" + documentSnapshot.data['ad'].toString());
    debugPrint("cacheden mi geldi" + documentSnapshot.data['para'].toString());
    documentSnapshot.data.forEach((key, value) {
      debugPrint("key : $key value: $value");
    });

    _firestore.collection("kullanicilar").getDocuments().then((querySnapshot) {
      debugPrint(" kullanicilardaki döküman sayısı : " +
          querySnapshot.documents.length.toString());

      for (int i = 0; i < querySnapshot.documents.length; i++) {
        querySnapshot.documents[i].data.toString();
      }
      //anlık değişiklik dinlenmesi
      DocumentReference ref =
          _firestore.collection("kullanicilar").document("deniz");

      ref.snapshots().listen((degisenVeri) {
        debugPrint("anlik  : " + degisenVeri.data.toString());
      });

      _firestore.collection("kullanicilar").snapshots().listen((snap) {
        debugPrint(snap.documents.length.toString());
      });
    });
  }

  void _veriSorgula() async {
    var dokumanlar = await _firestore
        .collection("kullanicilar")
        .where("email", isEqualTo: "addi@addi.com")
        .getDocuments();

    for (var dokuman in dokumanlar.documents) {
      debugPrint(dokuman.data.toString());
    }

    var limitGetir =
        await _firestore.collection("kullanicilar").limit(3).getDocuments();
    for (var dokuman in limitGetir.documents) {
      debugPrint("limiti getirenler " + dokuman.data.toString());
    }

    var diziSorgula = await _firestore
        .collection("kullanicilar")
        .where("dizi", arrayContains: "ezel")
        .getDocuments();

    for (var dokuman in diziSorgula.documents) {
      debugPrint("dizi : " + dokuman.data.toString());
    }

    var stringSorgula = await _firestore
        .collection("kullanicilar")
        .orderBy("email", descending: true)
        .startAt(['addi']).endAt(['addi' + '\uf8ff']).getDocuments();
    for (var dokuman in stringSorgula.documents) {
      debugPrint("string  : " + dokuman.data.toString());
    }

    _firestore
        .collection("kullanicilar")
        .document("deniz")
        .get()
        .then((docSnap) {
      debugPrint("veriler : " + docSnap.data.toString());

      // end at kullansaydık denizden az beğeni almışlar görünürdü
      _firestore
          .collection("kullanicilar")
          .orderBy("begeni")
          .startAt([docSnap.data['begeni']])
          .getDocuments()
          .then((querySnap) {
            if (querySnap.documents.length > 0) {
              for (var bb in querySnap.documents) {
                debugPrint(
                    "denizden fazla beğenilenler : " + bb.data.toString());
              }
            }
          });
    });
  }

  void _deneme() async {
    /* var dokumanlar = await _firestore
        .collection("kullanicilar")
        .where("email", isEqualTo: "addidagli@gmail.com")
        .getDocuments();

    for (var dokuman in dokumanlar.documents) {
                                  if(dokuman.data['email'] == _mail)
                                  debugPrint(dokuman.data['email'].toString());
                                }*/

   _firestore.collection("kullanicilar").getDocuments().then((querySnapshot) {
      debugPrint(" kullanicilardaki döküman sayısı : " +
          querySnapshot.documents.length.toString());

      for (int i = 0; i < querySnapshot.documents.length; i++) {
        debugPrint(querySnapshot.documents[i].data.toString());
      }
   });
  }

  void _galeriResim() async {
    var resim = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim = resim;
    });

    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("ev")
        .child("addi")
        .child("ev.png");

    StorageUploadTask uploadTask = ref.putFile(_secilenResim);

    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    debugPrint("resmin url : " + url);
  }

  void _kameraResim() async {
    var resim = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _secilenResim = resim;
    });
  }
}
