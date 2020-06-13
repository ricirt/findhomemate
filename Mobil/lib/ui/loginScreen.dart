import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/ui/loading.dart';
import 'package:deneme/ui/registerScreen.dart';
import 'package:deneme/ui/sorularOncesi.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Bu alan boş kalamaz!!' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Bu alan boş kalamaz!!' : null;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var mySharedPrefences;
  String mesaj = "";
  String _mail;
  String _sifre;
  bool _isSelected = false;
  bool _soruDurum;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sf) {
      mySharedPrefences = sf;
      _mailController.text =
          (mySharedPrefences as SharedPreferences).getString("myMail") ?? "";
      _passwordController.text = (mySharedPrefences as SharedPreferences)
              .getString("mySifre")
              .toString() ??
          "";
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    (mySharedPrefences as SharedPreferences).remove("myMail");
    (mySharedPrefences as SharedPreferences).remove("mySifre");
    mySharedPrefences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Padding(
                child: Center(
                  child: Text(
                    "GİRİŞ YAP",
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
                    margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            onSaved: (deger) {
                              _mail = deger;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _mailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Email giriniz",
                            ),
                          ),
                          TextFormField(
                            onSaved: (deger) {
                              _sifre = deger;
                            },
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Şifre giriniz",
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(),
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Checkbox(
                                          value: _isSelected,
                                          onChanged: (value) {
                                            setState(() {
                                              _isSelected = value;
                                            });
                                          },
                                          activeColor: Colors.green,
                                          checkColor: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Beni Hatırla",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: InkWell(
                                    child: Text("Şifremi unuttum !"),
                                    onTap: () {
                                      _sifremiUnuttum();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                              child: Text(
                                "GİRİŞ YAP",
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ));
                              },
                              child: Text(
                                "KAYIT OL",
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: Colors.green[400],
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
            ),
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
        .then((oturumAcmisKullanici) async {
      setState(() {
        loading = true;
      });

      if (oturumAcmisKullanici.user.isEmailVerified) {
        if (_isSelected == true) {
          formKey.currentState.save();
          await (mySharedPrefences as SharedPreferences)
              .setString("myMail", _mail);
          await (mySharedPrefences as SharedPreferences)
              .setString("mySifre", _sifre);
        }
        final FirebaseUser user = await _auth.currentUser();
        final String uid = user.uid;

        if (user != null) {
          DocumentSnapshot documentSnapshot =
              await _firestore.document("kullanicilar/$uid").get();

          setState(() {
            _soruDurum = documentSnapshot.data['soruDurum'];
          });
        }

        if (_soruDurum == false) {
          setState(() {
            loading = true;
          });
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return SorularOncesi();
          }));
        } else {
          setState(() {
            loading = true;
          });
          Navigator.pushNamed(context, "/mainPageScreen");
        }
        //Navigator.pushNamed(context, "/mainPageScreen");
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
