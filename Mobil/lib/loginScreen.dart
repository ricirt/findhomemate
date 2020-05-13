import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  String mesaj = "";
  String _mail;
  String _sifre;


  @override
  void initState() {
    super.initState();

   
    _auth.onAuthStateChanged.listen((user) {
      setState(() {
        if (user != null) {
          mesaj = "\nListener tetiklendi kullanıcı oturum açtı";
        } else {
          mesaj = "\nListener tetiklendi kullanıcı oturum kapattı";
        }
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    //_mailController.dispose();
    //_passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(fontSize: 36, color: Colors.red),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _mailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email giriniz",
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Şifre giriniz",
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: InkWell(
                        child: Text("Şifremi unuttum !"),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            _emailveSifreLogin();
                          },
                          child: Text("Giriş Yap"),
                          color: Colors.blueAccent,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/registerScreen');
                          },
                          child: Text("Kaydol"),
                          color: Colors.grey,
                        ),
                      ),
                    ]),
              ),
              Text(mesaj),
            ],
          ),
        ],
      )),
    );
  }

 void _emailveSifreLogin() {
     _mail = _mailController.text;
     _sifre = _passwordController.text;
     
    _auth
        .signInWithEmailAndPassword(email: _mail, password: _sifre)
        .then((oturumAcmisKullanici) {
      if (oturumAcmisKullanici.user.isEmailVerified) {
        Navigator.pushNamed(context, "/mainPageScreen");
      } else {
        mesaj = "\nEmailinizi onaylayın";
        _auth.signOut();
      }
      setState(() {});
    }).catchError((hata) {
      debugPrint(hata.toString());
      setState(() {
        mesaj = "\nEmail veya şifre yanlış";
      });
    });
  }
}
