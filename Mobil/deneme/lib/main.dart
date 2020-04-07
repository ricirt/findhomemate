import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'registerScreen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/loginScreen",
      routes: {
        '/': (context) => LoginScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/registerScreen': (context) => RegisterScreen(),
        '/mainPageScreen': (context) => RegisterScreen(),

      },
      debugShowCheckedModeBanner: false,
     
      //home: NavigasyonIslemleri()
    ),
  );
}
