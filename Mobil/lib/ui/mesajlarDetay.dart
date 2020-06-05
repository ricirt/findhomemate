import 'package:flutter/material.dart';

class MesajlarDetay extends StatefulWidget {
  @override
  _MesajlarDetayState createState() => _MesajlarDetayState();
}

class _MesajlarDetayState extends State<MesajlarDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40,
            child: Image.asset("assets/logo.png"), // Kişinin resmi
          ),
        ),
        //// Mesajlaştıgı kısının adı
        title: InkWell(
          child: Text("Kişinin Adı"),
        ),
        /*actions: <Widget>[
        IconButton(icon: null, onPressed: null)
      ],*/
      ),
      body: Expanded(
        child: Column(
          children: <Widget>[
            
            
          ],
        ),
      ),
    );
  }
}
/*Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(25),
                                  right: Radius.circular(25))),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Bir mesaj yazın...",
                                border: InputBorder.none),
                          )))
                ],
              ),
            )
            
            
            
            
            ListView.builder(
                
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Align(
                    child: Text("Deneme mesajı"),
                    alignment: index % 2 == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                  ));
                }),
            
            
            */