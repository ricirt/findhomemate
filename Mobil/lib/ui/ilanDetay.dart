import 'package:deneme/ui/anasayfa.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:deneme/ui/profile.dart';

String price;
class ilanDetay extends StatefulWidget {
  @override
  _ilanDetayState createState() => _ilanDetayState();
}

class _ilanDetayState extends State<ilanDetay> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: screenHeight * 0.6,
            width: double.infinity,
            child: Image.network(
              "http://www.kocerdemyapi.com/wp-content/uploads/2018/09/dMhgct-house-png-home-background-1.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.5),
            height: screenHeight,
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
              child: Container(
                padding: EdgeInsets.only(top: 30, left: 20, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "\$4,999",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Icon(Icons.bookmark_border, color: Colors.purple),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.purple.shade200,
                          child: Text(
                            "Mesaj at ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext) {
                                return ProfilePage();
                              }));
                            });                          
                          },
                          color: Colors.purple.shade200,
                          child: Text(
                            "${kisi.adSoyad}'in Profiline git ",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Sigara",
                              style: _style(),
                            ),
                            Icon(ozellik[0].sigara == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Alkol",
                              style: _style(),
                            ),
                            Icon(ozellik[0].alkol == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Evcil Hayvan",
                              style: _style(),
                            ),
                            Icon(ozellik[0].evcilHayvan == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Cinsiyet",
                              style: _style(),
                            ),
                            Icon(ozellik[0].cinsiyet == true
                                ? Icons.pregnant_woman
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Garaj",
                              style: _style(),
                            ),
                            Icon(ozellik[0].garaj == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Wifi",
                              style: _style(),
                            ),
                            Icon(ozellik[0].wifi == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "TV",
                              style: _style(),
                            ),
                            Icon(ozellik[0].tv == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Fatura ortaklığı",
                              style: _style(),
                            ),
                            Icon(ozellik[0].fatura == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Doğalgaz",
                              style: _style(),
                            ),
                            Icon(ozellik[0].dogalgaz == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Eşya",
                              style: _style(),
                            ),
                            Icon(ozellik[0].esya == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Misafir",
                              style: _style(),
                            ),
                            Icon(
                              ozellik[0].misafir == true
                                  ? Icons.check
                                  : Icons.cancel,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Depozito",
                              style: _style(),
                            ),
                            Icon(ozellik[0].depozito == true
                                ? Icons.check
                                : Icons.cancel),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }
}
