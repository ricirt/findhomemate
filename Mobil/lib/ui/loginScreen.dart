import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

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
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    //_mailController.text = SharedPrefsHelper.getMailForRememberMe;
    //_passwordController.text = SharedPrefsHelper.getPasswordForRememberMe;

    _auth.onAuthStateChanged.listen((user) {
      setState(() {
        if (user != null) {
          //mesaj = "\nListener tetiklendi kullanıcı oturum açtı";
          SnackBar(content: Text("Listener tetiklendi kullanıcı oturum açtı"));
        } else {
          // mesaj = "\nListener tetiklendi kullanıcı oturum kapattı";
          SnackBar(
              content: Text("Listener tetiklendi kullanıcı oturum kapattı"));
        }
      });
    });
  }

  /*@override
  void dispose() {
    super.dispose();
  }*/

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
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Beni Hatırla",
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            child: Checkbox(
                              value: _isSelected,
                              onChanged: (value) {
                                setState(() {
                                  _isSelected = value;
                                });
                              },
                              activeColor: Colors.grey,
                              checkColor: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            child: Text("Şifremi unuttum !"),
                            onTap: () {
                              _sifremiUnuttum();
                            },
                          ),
                        ],
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
                            /*if (_mailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              if (_isSelected) {
                                SharedPrefsHelper.saveMailForRememberMe(
                                    _mailController.text);
                                SharedPrefsHelper.savePasswordForRememberMe(
                                    _passwordController.text);
                              }
                              SharedPrefsHelper.saveMail(_mailController.text);
                              SharedPrefsHelper.savePassword(
                                  _passwordController.text);
                            }*/
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
                          child: Text("Kayıt Ol"),
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 20),
                          child: GoogleSignInButton(
                            text: "Google ile Giriş Yap",
                            onPressed: () {
                              _googleGiris();
                            },
                            splashColor: Colors.white,
                            // setting splashColor to Colors.transparent will remove button ripple effect.
                          )),
                    ]),
              ),
              Text(mesaj),
            ],
          ),
        ],
      )),
    );
  }

  void _googleGiris() {
    _googleAuth.signIn().then((sonuc) {
      sonuc.authentication.then((googleKeys) {
        AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleKeys.idToken, accessToken: googleKeys.accessToken);

        _auth.signInWithCredential(credential).then((user) {
          Navigator.pushNamed(context, "/mainPageScreen");
          //mesaj += "Gmail ile giriş yapıldı\n User id : ${user.user.uid}\n mail : ${user.user.email}";
        }).catchError((hata) {
          //mesaj += "\nGoogle kullanıcı hatası $hata";
          Fluttertoast.showToast(
            msg: "Google kullanıcı hatası $hata",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      }).catchError((hata) {
        Fluttertoast.showToast(
          msg: "Google Authentication hatası $hata",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        //mesaj += "\nGoogle Authentication hatası $hata";
      });
    }).catchError((hata) {
      Fluttertoast.showToast(
        msg: "Google Auth signin hatası $hata",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      //mesaj += "\nGoogle Auth signin hatası $hata";
    });
    setState(() {});
  }

  void _sifremiUnuttum() {
    _mail = _mailController.text;

    _auth.sendPasswordResetEmail(email: _mail).then((v) {
      Fluttertoast.showToast(
        msg: "sıfırlama maili gönderildi",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }).catchError((hata) {
      Fluttertoast.showToast(
        msg: "Hata oluştu : Lütfen mailinizi yazınız",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
    setState(() {});
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
        Fluttertoast.showToast(
          msg: "Emailinizi onaylayın",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _auth.signOut();
      }
      setState(() {});
    }).catchError((hata) {
      debugPrint(hata.toString());

      Fluttertoast.showToast(
        msg: "Kullanıcı adı veya şifre yanlış",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
    setState(() {});
  }
}
