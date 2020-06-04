import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilDuzenle extends StatefulWidget {
  @override
  _ProfilDuzenleState createState() => _ProfilDuzenleState();
}

class _ProfilDuzenleState extends State<ProfilDuzenle> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _checkPasswordController = TextEditingController();
  final _adSoyadController = TextEditingController();
  final _dogumYiliController = TextEditingController();
  final _meslekController = TextEditingController();
  String mesaj = "";
  int selectedRadio;

  @override
  void initState() {
    super.initState();

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
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  "Profili Güncelle",
                  style: TextStyle(fontSize: 36, color: Colors.teal),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _adSoyadController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      hintText: "Ad-soyad",
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _mailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Şifre",
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _checkPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Şifre Tekrar",
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _dogumYiliController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      hintText: "Doğum Yılı(Örn: 1996)",
                    ),
                  ),
                  TextFormField(
                    controller: _meslekController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.card_travel),
                      hintText: "Meslek",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Kadın"),
                      Radio(
                        groupValue: selectedRadio,
                        value: 1,
                        onChanged: (val) {
                          setSelectedRadio(val);
                        },
                      ),
                      Text("Erkek"),
                      Radio(
                        groupValue: selectedRadio,
                        value: 2,
                        onChanged: (val) {
                          setSelectedRadio(val);
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        _emailveSifreCreateUser();
                      },
                      child: Text("Güncelle"),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _emailveSifreCreateUser() async {
    String _mail = _mailController.text;
    String _sifre = _passwordController.text;
    String _adSoyad = _adSoyadController.text;
    String _checkPassword = _checkPasswordController.text;
    String _dogumYili = _dogumYiliController.text;
    String _meslek = _meslekController.text;
    String _cinsiyet = "";
    int yas;
    yas = int.parse(_dogumYili);
    yas = 2020 - yas;
    _dogumYili = yas.toString();

    if (selectedRadio == 1) {
      _cinsiyet = "kadın";
    } else if (selectedRadio == 2) {
      _cinsiyet = "erkek";
    }
    if (_sifre.length >= 6) {
      if (_sifre == _checkPassword) {
        final FirebaseUser user = await _auth.currentUser();
        final String uid = user.uid;

        _firestore.collection("kullanicilar").document("$uid").setData({
          "adSoyad": _adSoyad,
          "email": _mail,
          "sifre": _sifre,
          "dogumYili": _dogumYili,
          "meslek": _meslek,
          "cinsiyet": _cinsiyet,
        }, merge: true);

        Fluttertoast.showToast(
          msg: "Bilgiler Güncellendi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Şifreler uyuşmuyor",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Şifre 6 karakterden az olamaz",
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
