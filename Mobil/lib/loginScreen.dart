import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email giriniz",
                      ),
                    ),
                    TextFormField(
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
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context,'/mainPageScreen');
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
                            Navigator.pushNamed(context,'/registerScreen' );
                          },
                          child: Text("Kaydol"),
                          color: Colors.grey,
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ],
      )),
    );
  }
}
