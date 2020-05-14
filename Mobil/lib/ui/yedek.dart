import 'package:flutter/material.dart';

class YedekScreen extends StatefulWidget {
  @override
  _YedekScreenState createState() => _YedekScreenState();
}

class _YedekScreenState extends State<YedekScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Image.asset("assets/background.jpg"),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 50.0),
              child: Column(
                children: <Widget>[
                  
                
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Beni Hatırla",
                          style: TextStyle(
                              fontSize: 16, fontFamily: "Poppins-Medium")),
                      
                      SizedBox(),
                      InkWell(
                        child: Text(
                          "Şifremi Unuttum",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Poppins-Medium",
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/changePassword");
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
          
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.red.shade300, Colors.red.shade700]),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/mainPage");
                          },
                          child: Center(
                            child: Text("GİRİŞ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "CustomIcon",
                                    fontSize: 22,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                
                  InkWell(
                    child: Text(
                      "Henüz hesabin yok mu? Kayit Ol",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Poppins-Medium",
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/register");
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  
    );
  }
}
