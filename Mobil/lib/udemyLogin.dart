import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginIslemleri extends StatefulWidget {
  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();
  String mesaj = "";

  @override
  void initState() {
    super.initState();

    _auth.onAuthStateChanged.listen((user) {
      setState(() {
        if (user != null) {
          mesaj += "\nListener tetiklendi kullanıcı oturum açtı";
        } else {
          mesaj += "\nListener tetiklendi kullanıcı oturum kapattı";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Authentication"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text(
                "Email/Şifre Yeni Kullanici",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: _emailveSifreCreateUser,
            ),
            RaisedButton(
              child: Text(
                "Email/Şifre Login",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
              onPressed: _emailveSifreLogin,
            ),
            RaisedButton(
              child: Text(
                "Çıkış Yap",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: _cikisYap,
            ),
            RaisedButton(
              child: Text(
                "Şifremi Unuttum",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.pink,
              onPressed: _sifremiUnuttum,
            ),
            RaisedButton(
              child: Text(
                "Şifremi Güncelle",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.amber,
              onPressed: _sifremiGuncelle,
            ),
            RaisedButton(
              child: Text(
                "Email Güncelle",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.grey,
              onPressed: _emailGuncelle,
            ),
            RaisedButton(
              child: Text(
                "Gmail ile Oturum aç",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueGrey,
              onPressed: _googleGiris,
            ),
            Text(mesaj),
          ],
        ),
      ),
    );
  }

  void _googleGiris() {
    _googleAuth.signIn().then((sonuc) {
      sonuc.authentication.then((googleKeys) {
        AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleKeys.idToken, accessToken: googleKeys.accessToken);

        _auth.signInWithCredential(credential).then((user){
          mesaj += "Gmail ile giriş yapıldı\n User id : ${user.user.uid}\n mail : ${user.user.email}";

        }).catchError((hata){
          mesaj += "\nGoogle kullanıcı hatası $hata";
        });
      }).catchError((hata) {
        
        mesaj += "\nGoogle Authentiğcation hatası $hata";
      });
    }).catchError((hata) {
      mesaj += "\nGoogle Auth signin hatası $hata";
    });
    setState(() {});
  }

  void _emailGuncelle() {
    _auth.currentUser().then((user) {
      if (user != null) {
        user.updateEmail("edmunddantes1001@gmail.com").then((a) {
          mesaj += "\nEmail GÜncellendi";
        }).catchError((hata) {
          mesaj += "\nEmail GÜncellenirken hata oluştu $hata";
        });
      } else {
        mesaj += "\nEmaili değiştirmek için giriş yapman lazım";
      }
    }).catchError((hata) {
      mesaj += "\nKullanıcı getirilirken hata $hata";
    });
    setState(() {});
  }

  void _sifremiGuncelle() {
    _auth.currentUser().then((user) {
      if (user != null) {
        user.updatePassword("234567").then((a) {
          mesaj += "\nŞifre GÜncellendi";
        }).catchError((hata) {
          mesaj += "\nŞifre GÜncellenirken hata oluştu $hata";
        });
      } else {
        mesaj += "\nŞifreyi değiştirmek için giriş yapman lazım";
      }
    }).catchError((hata) {
      mesaj += "\nKullanıcı getirilirken hata $hata";
    });
    setState(() {});
  }

  void _sifremiUnuttum() {
    String mail = "addidagli@gmail.com";

    _auth.sendPasswordResetEmail(email: mail).then((v) {
      mesaj = "sıfırlama maili gönderildi";
    }).catchError((hata) {
      mesaj = "Şifremi unuttum mailinde hata $hata";
    });
    setState(() {});
  }

  void _cikisYap() async {
    if (await _auth.currentUser() != null) {
      _auth.signOut().then((data) {
        _googleAuth.signOut();
        mesaj += "\nKullanıcı çıkış yaptı";
      }).catchError((hata) {
        mesaj += "\nÇıkış yaparken hata oluştu $hata";
      });
    } else {
      mesaj += "\nOturum açmış kullanıcı yok";
    }

    setState(() {});
  }

  void _emailveSifreLogin() {
    String mail = "addidagli@gmail.com";
    String sifre = "123456";

    _auth
        .signInWithEmailAndPassword(email: mail, password: sifre)
        .then((oturumAcmisKullanici) {
      if (oturumAcmisKullanici.user.isEmailVerified) {
        mesaj += "\nEmail onaylı kullanıcı yönlendirme yapabilirsin";
      } else {
        mesaj += "\nEmailinizi onaylayın";
        _auth.signOut();
      }
      setState(() {});
    }).catchError((hata) {
      debugPrint(hata.toString());
      setState(() {
        mesaj += "\nEmail veya şifre yanlış";
      });
    });
  }

  void _emailveSifreCreateUser() async {
    String mail = "addidagli@gmail.com";
    String sifre = "123456";

    var firebaseUser = await _auth
        .createUserWithEmailAndPassword(email: mail, password: sifre)
        .catchError((e) => debugPrint("hata :" + e.toString()));

    if (firebaseUser != null) {
      firebaseUser.user.sendEmailVerification().then((data) {
        _auth.signOut();
      }).catchError((e) => debugPrint("Mail gönderilirken hata $e"));

      setState(() {
        mesaj =
            "Uid ${firebaseUser.user.uid} mail : ${firebaseUser.user.email} mailOnayi : ${firebaseUser.user.isEmailVerified}\n Email gönderildi lütfen onaylayın";
      });
      debugPrint(
          "Uid ${firebaseUser.user.uid} mail : ${firebaseUser.user.email} mailOnayi : ${firebaseUser.user.isEmailVerified}");
    } else {
      mesaj = "bu mail zaten var";
    }
  }
}
