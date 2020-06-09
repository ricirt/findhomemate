import 'package:deneme/ui/ilanVer.dart';
import 'package:flutter/material.dart';

class Bildirim extends StatefulWidget {
  @override
  BildirimState createState() {
    return new BildirimState();
  }
}

class BildirimState extends State<Bildirim> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Text(
              "BİLDİRİMLER",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 29,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext ctxt, int index) =>
                      _anasayfaGridKisi(ctxt, index)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _anasayfaGridKisi(BuildContext ctxt, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)),
      ),
      elevation: 15.0,
      child: Container(
        child: ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return IlanVer();
            }));
          },

          enabled: true,
          //////// bildirime sebep olan kişinin fotoğrafı
          leading: FlutterLogo(),
          //selected: true,
          //isThreeLine: true,
          //title: Text("bildirim ${index}"),
          subtitle: Text(
            "1-Fatih Öztemir Size mesaj attı. (Bildirim ${index}). 2- Fatih Öztemir size x puan verdi. " +
                "3-Fatih Öztemir Sizin Profilinize Baktı(?). 4-Naşka neler olabılır düşün ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
