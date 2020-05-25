import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKullanimi extends StatefulWidget {
  @override
  _SharedPrefKullanimiState createState() => _SharedPrefKullanimiState();
}

class _SharedPrefKullanimiState extends State<SharedPrefKullanimi> {
  String _isim;
  String _sifre;
  var formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  var myShared;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sf) {
      myShared = sf;
    });
  }

  @override
  void dispose() {
    myShared.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (deger) {
                  _isim = deger;
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
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Beni Hatırla",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      child: Text("Şifremi unuttum !"),
                      onTap: () {},
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
                          _ekle();
                        },
                        child: Text("Ekle"),
                        color: Colors.blueAccent,
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
                          _goster();
                        },
                        child: Text("Göster"),
                        color: Colors.blueAccent,
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
                          _sil();
                        },
                        child: Text("Sil"),
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _ekle() async {
    formKey.currentState.save();
    await (myShared as SharedPreferences).setString("myIsim", _isim);
    await (myShared as SharedPreferences).setString("mySifre", _sifre);
  }

  void _goster() {
    debugPrint(
        "Okunan isim " + (myShared as SharedPreferences).getString("myIsim") ??
            "NULLLL");
    debugPrint("Okunan sifre " +
            (myShared as SharedPreferences).getString("mySifre").toString() ??
        "NULL");
  }

  void _sil() {
    (myShared as SharedPreferences).remove("myIsim");
    (myShared as SharedPreferences).remove("mySifre");
  }
}
