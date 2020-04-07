import 'package:flutter/material.dart';
import 'anasayfa.dart';
import 'arama.dart';
import 'pageview.dart';
import 'bildirim.dart';
import 'mesajlar.dart';

class MainPageScreen extends StatefulWidget {
  @override
  _MainPageScreen createState() => _MainPageScreen();
}

class _MainPageScreen extends State<MainPageScreen> {
  int secilenMenuItem = 0;
  List<Widget> tumSayfalar;
  Anasayfa sayfaAna;
  AramaSayfasi sayfaArama;
  PageViewOrnek pageViewOrnek;
  Bildirim bildirim;
  Mesajlar mesajlar;
  
  var keyAnasayfa = PageStorageKey("key_anasayfa");
  var keyArama = PageStorageKey("key_arama");

  @override
  void initState(){
    super.initState();
    sayfaAna = Anasayfa(keyAnasayfa);
    sayfaArama = AramaSayfasi(keyArama);
    pageViewOrnek = PageViewOrnek();
    bildirim = Bildirim();
    mesajlar = Mesajlar();
    tumSayfalar=[sayfaAna,sayfaArama,pageViewOrnek,bildirim,mesajlar];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FindHomemate"),
      ),
      body: tumSayfalar[secilenMenuItem],
      bottomNavigationBar: bottomNavMenu(),
    );
  }

  Theme bottomNavMenu() {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.amber,
        primaryColor: Colors.green,
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Anasayfa"),
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.account_circle),
              title: Text("Ara"),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text("Profil"),
              backgroundColor: Colors.teal),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              title: Text("Bildirimler"),
              backgroundColor: Colors.green),
              BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Mesajlar"),
              backgroundColor: Colors.amber),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: secilenMenuItem,
        fixedColor: Colors.indigo,
        onTap: (index) {
          setState(() {
            secilenMenuItem = index;
           
          });
        },
      ),
    );
  }
}