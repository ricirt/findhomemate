import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {

Anasayfa(Key k) : super(key: k);


  @override
  AnasayfaState createState() {
    return new AnasayfaState();
  }
}

class AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("ANASAYFA",style: TextStyle(fontSize: 24),)),
    );
    
    /*ListView.builder(
      itemBuilder: (context, index) {
        return ExpansionTile(
          key: PageStorageKey("$index"),
         
          title: Text("ANASAYFA", style: TextStyle(fontSize: 24)),
          children: <Widget>[
            Container(
              color:
                  index % 2 == 0 ? Colors.red.shade200 : Colors.yellow.shade300,
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
               
              ),
            ),
          ],
        );
      },
    );*/
  }
}
