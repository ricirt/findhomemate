import 'package:deneme/ui/anasayfa.dart';
import 'package:flutter/material.dart';
import 'ui/loginScreen.dart';
import 'ui/registerScreen.dart';
import 'ui/mainPageScreen.dart';
import 'Widgets/features.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/loginScreen",
      routes: {
        '/': (context) => LoginScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/registerScreen': (context) => RegisterScreen(),
        '/mainPageScreen': (context) => MainPageScreen(),
        '/homePageScreen':(context)=>Anasayfa(),

      },
      debugShowCheckedModeBanner: false,
     
      //home: NavigasyonIslemleri()
    ),
  );
}
