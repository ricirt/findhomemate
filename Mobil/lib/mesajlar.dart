import 'package:flutter/material.dart';

class Mesajlar extends StatefulWidget {


  @override
  MesajlarState createState() {
    return new MesajlarState();
  }
}

class MesajlarState extends State<Mesajlar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("MESAJLAR",style: TextStyle(fontSize: 24),)),
    );
  }
}