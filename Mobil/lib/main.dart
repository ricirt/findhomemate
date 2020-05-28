import 'package:deneme/ui/anasayfa.dart';
import 'package:deneme/ui/bildirim.dart';
import 'package:deneme/ui/profiliDuzenle.dart';
import 'package:flutter/material.dart';
import 'ui/loginScreen.dart';
import 'ui/registerScreen.dart';
import 'ui/mainPageScreen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/loginScreen",
      routes: {
        '/': (context) => LoginScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/bildirim': (context) => Bildirim(),
        '/editProfile': (context) => ProfilDuzenle(),
        '/registerScreen': (context) => RegisterScreen(),
        '/mainPageScreen': (context) => MainPageScreen(),
        '/homePageScreen': (context) => Anasayfa(),
      },
      debugShowCheckedModeBanner: false,

      //home: NavigasyonIslemleri()
    ),
  );
}
