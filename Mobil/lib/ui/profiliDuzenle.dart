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
  final _sehirController = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Center(
            child: Text(
              "PROFİL DÜZENLE",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    controller: _sehirController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: "Şehir",
                    ),
                  ),
                  TextFormField(
                    controller: _meslekController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.card_travel),
                      hintText: "Meslek",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          groupValue: selectedRadio,
                          value: 1,
                          onChanged: (val) {
                            setSelectedRadio(val);
                          },
                        ),
                        Text("Kadın"),
                        Radio(
                          groupValue: selectedRadio,
                          value: 2,
                          onChanged: (val) {
                            setSelectedRadio(val);
                          },
                        ),
                        Text("Erkek"),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 300,
                    child: FlatButton(
                      onPressed: () {
                        _emailveSifreCreateUser();
                      },
                      child: Text(
                        "GÜNCELLE",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.blue[400],
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
    String _sehir = _sehirController.text;
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
          "konum": _sehir, 
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
