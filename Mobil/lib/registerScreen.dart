import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  String mesaj = "";
  String _mail;
  String _sifre;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                "Kaydol",
                style: TextStyle(fontSize: 36, color: Colors.teal),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: "Ad-soyad",
                  ),
                ),
                TextFormField(
                  controller: _mailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Şifre",
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Şifre Tekrar",
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    hintText: "Doğum tarihi",
                  ),
                ),
                
                Container(
                  margin: EdgeInsets.only(top:20),
                  width: 300,
                  child: FlatButton(
                    onPressed: () {
                      _emailveSifreCreateUser();
                    },
                    child: Text("Kaydol"),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _emailveSifreCreateUser() async {
    String _mail = _mailController.text;
    String _sifre = _passwordController.text;

    var firebaseUser = await _auth
        .createUserWithEmailAndPassword(email: _mail, password: _sifre)
        .catchError((e) => debugPrint("hata :" + e.toString()));

    if (firebaseUser != null) {
      firebaseUser.user.sendEmailVerification().then((data) {
        _auth.signOut();
      }).catchError((e) => debugPrint("Mail gönderilirken hata $e"));

      setState(() {
        mesaj =
            "Uid ${firebaseUser.user.uid} mail : ${firebaseUser.user.email} mailOnayi : ${firebaseUser.user.isEmailVerified}\n Email gönderildi lütfen onaylayın";
      });
      Navigator.pushNamed(context, "/loginScreen");
      debugPrint(
          "Uid ${firebaseUser.user.uid} mail : ${firebaseUser.user.email} mailOnayi : ${firebaseUser.user.isEmailVerified}");
    } else {
      mesaj = "bu mail zaten var";
    }
  }
}

