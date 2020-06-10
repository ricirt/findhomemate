
import 'package:flutter/material.dart';
import 'anasayfa.dart';
import 'profile.dart';
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
  Profile profile;
  Bildirim bildirim;
  Mesajlar mesajlar;

  var keyAnasayfa = PageStorageKey("key_anasayfa");

  @override
  void initState() {
    super.initState();
    sayfaAna = Anasayfa();
    profile = Profile();
    bildirim = Bildirim();
    mesajlar = Mesajlar();
    tumSayfalar = [sayfaAna, profile, bildirim, mesajlar];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
            title: Text(tumSayfalar[secilenMenuItem].toString()),
            actions: <Widget>[
                // action button
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, "/settings");
                  },
                ),
            ],
          ),*/
      body: tumSayfalar[secilenMenuItem],
      bottomNavigationBar: bottomNavMenu(),
    );
  }

  Theme bottomNavMenu() {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.white24,
        primaryColor: Colors.green,
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Anasayfa"),
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Profil"),
              backgroundColor: Colors.teal),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text("Bildirimler"),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.email),
              title: Text("Mesajlar"),
              backgroundColor: Colors.amber),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: secilenMenuItem,
        fixedColor: Colors.blue,
        onTap: (index) {
          setState(() {
            secilenMenuItem = index;
          });
        },
      ),
    );
  }
}
