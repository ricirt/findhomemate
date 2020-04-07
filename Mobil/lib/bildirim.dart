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
    return Container(
      child: Center(child: Text("BİLDİRİM",style: TextStyle(fontSize: 24),)),
    );
  }
}