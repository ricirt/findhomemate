import 'package:deneme/ui/mainPageScreen.dart';
import 'package:flutter/material.dart';

import 'anasayfa.dart';

class Sorular extends StatefulWidget {
  @override
  _SorularState createState() => _SorularState();
}

class _SorularState extends State<Sorular> {
  static String RadioHayvan = "Hayvan",
      RadioSigara = "Sigara",
      RadioAlkol = "Alkol",
      RadioWifi = "Wifi",
      RadioTv = "TV",
      RadioFatura = "Fatura",
      RadioEsya = "Esya",
      RadioCinsiyet = "Cinsiyet",
      RadioGaraj = "Garaj",
      RadioDogalgaz = "Dogalgaz",
      RadioDepozito = "Depozito",
      RadioMisafir = "Misafir";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Text(
            "Sorular",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          Text(
            "Evcil hayvan sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioHayvan,
                      onChanged: (T) {
                        setState(() {
                          RadioHayvan = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioHayvan,
                      onChanged: (T) {
                        setState(() {
                          RadioHayvan = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Evde sigara içilmesi sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioSigara,
                      onChanged: (T) {
                        setState(() {
                          RadioSigara = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioSigara,
                      onChanged: (T) {
                        setState(() {
                          RadioSigara = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Evde Alkol içilmesi sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioAlkol,
                      onChanged: (T) {
                        setState(() {
                          RadioAlkol = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioAlkol,
                      onChanged: (T) {
                        setState(() {
                          RadioAlkol = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Evde WİFİ olmaması sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioWifi,
                      onChanged: (T) {
                        setState(() {
                          RadioWifi = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioWifi,
                      onChanged: (T) {
                        setState(() {
                          RadioWifi = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Evde TV olmaması sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioTv,
                      onChanged: (T) {
                        setState(() {
                          RadioTv = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioTv,
                      onChanged: (T) {
                        setState(() {
                          RadioTv = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Evin Faturalarına olmak sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioFatura,
                      onChanged: (T) {
                        setState(() {
                          RadioFatura = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioFatura,
                      onChanged: (T) {
                        setState(() {
                          RadioFatura = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Eşyalı bir ev mi arıyorsunuz?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioEsya,
                      onChanged: (T) {
                        setState(() {
                          RadioEsya = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioEsya,
                      onChanged: (T) {
                        setState(() {
                          RadioEsya = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Cinsiyetiniz Nedir?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Kadın",
                      groupValue: RadioCinsiyet,
                      onChanged: (T) {
                        setState(() {
                          RadioCinsiyet = T;
                        });
                      }),
                  Text("Kadın"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Erkek",
                      groupValue: RadioCinsiyet,
                      onChanged: (T) {
                        setState(() {
                          RadioCinsiyet = T;
                        });
                      }),
                  Text("Erkek"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Evin Garajı olmaması sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioGaraj,
                      onChanged: (T) {
                        setState(() {
                          RadioGaraj = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioGaraj,
                      onChanged: (T) {
                        setState(() {
                          RadioGaraj = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Evin doğalgaz ısıtması olmaması sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioDogalgaz,
                      onChanged: (T) {
                        setState(() {
                          RadioDogalgaz = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioDogalgaz,
                      onChanged: (T) {
                        setState(() {
                          RadioDogalgaz = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Ev Depozitosunun olmaması sizin için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioDepozito,
                      onChanged: (T) {
                        setState(() {
                          RadioDepozito = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioDepozito,
                      onChanged: (T) {
                        setState(() {
                          RadioDepozito = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            "Eve Misafir yasağı olması için sorun olur mu?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Evet",
                      groupValue: RadioMisafir,
                      onChanged: (T) {
                        setState(() {
                          RadioMisafir = T;
                        });
                      }),
                  Text("Evet"),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: "Hayir",
                      groupValue: RadioMisafir,
                      onChanged: (T) {
                        setState(() {
                          RadioMisafir = T;
                        });
                      }),
                  Text("Hayır"),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return MainPageScreen();
                }));
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text('Devam Et ', style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          SizedBox(height:20),
        ],
      ),
    ));
  }
}
