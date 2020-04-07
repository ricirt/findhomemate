import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'registerScreen.dart';
import 'mainPageScreen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/loginScreen",
      routes: {
        '/': (context) => LoginScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/registerScreen': (context) => RegisterScreen(),
        '/mainPageScreen': (context) => MainPageScreen(),

      },
      debugShowCheckedModeBanner: false,
     
      //home: NavigasyonIslemleri()
    ),
  );
}
