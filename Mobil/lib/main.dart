import 'package:deneme/anasayfa.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'registerScreen.dart';
import 'mainPageScreen.dart';
import 'Widgets/features.dart';
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
