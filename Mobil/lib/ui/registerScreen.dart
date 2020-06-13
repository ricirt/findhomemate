import 'package:deneme/ui/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        backgroundColor: Colors.green[400],
        title: Padding(
          padding: const EdgeInsets.only(right: 80),
          child: Center(
            child: Text(
              "KAYIT OL",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
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
                    margin: EdgeInsets.only(top: 10),
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
                        "KAYIT OL",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.green[400],
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
    bool _soruDurum = false;
    int yas;
    yas = int.parse(_dogumYili);
    yas = 2020 - yas;
    _dogumYili = yas.toString();

    if (selectedRadio == 1) {
      _cinsiyet = "kadın";
    } else if (selectedRadio == 2) {
      _cinsiyet = "erkek";
    }

    if (_adSoyad != "" &&
        _sifre != "" &&
        _mail != "" &&
        _checkPassword != "" &&
        _dogumYili != "" &&
        _meslek != "" &&
        _sehir != "") {
      if (_sifre.length >= 6) {
        if (_sifre == _checkPassword) {
          var firebaseUser = await _auth
              .createUserWithEmailAndPassword(
                  email: _mail.trim(), password: _sifre)
              .catchError((e) => debugPrint("hata :" + e.toString()));

          if (firebaseUser != null) {
            firebaseUser.user.sendEmailVerification().then((data) {
              _auth.signOut();
            }).catchError((e) => debugPrint("Mail gönderilirken hata $e"));

            setState(() {
              mesaj =
                  "Uid ${firebaseUser.user.uid} mail : ${firebaseUser.user.email} mailOnayi : ${firebaseUser.user.isEmailVerified}\n Email gönderildi lütfen onaylayın";
            });

            _firestore
                .collection("kullanicilar")
                .document("${firebaseUser.user.uid}")
                .setData({
              "adSoyad": _adSoyad,
              "email": _mail,
              "sifre": _sifre,
              "dogumYili": _dogumYili,
              "meslek": _meslek,
              "cinsiyet": _cinsiyet,
              "soruDurum": _soruDurum,
              "puan": 5,
              "oylayan": 1,
              "uid": firebaseUser.user.uid,
              "profilResmi":
                  "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-social-media-user-vector-default-avatar-profile-icon-social-media-user-vector-portrait-176194876.jpg",
              "konum": _sehir,
            });

            Fluttertoast.showToast(
              msg: "Kayıt Başarılı",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 2,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0,
            );

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
            debugPrint(
                "Uid ${firebaseUser.user.uid} mail : ${firebaseUser.user.email} mailOnayi : ${firebaseUser.user.isEmailVerified}");
          } else {
            Fluttertoast.showToast(
              msg: "Bu mail zaten var",
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
    } else {
      Fluttertoast.showToast(
        msg: "Lütfen tüm alanları doldurun",
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
