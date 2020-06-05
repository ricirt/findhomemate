import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/ui/mesajlarDetay.dart';
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
    return StreamBuilder(
      //Fire baseye messaages bolumu eklendıkten sonra revize edilecek.
      stream: Firestore.instance.collection('messages').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        /// eger snapshotta hata varsa
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error} ");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          /// Gif koyulabılır
          return Text("loading...");
        }
        return ListView(
          ///// ---------Kimlerle mesajlastıgını gösteren sayfa.
          ///// Firebaseye uygun bir şekilde tekrar revize edilecek.
          children: snapshot.data.documents
              .map((doc) => ListTile(
                    leading: CircleAvatar(
                        //Mesajlaşılanın kişinin fotografı
                        //backgroundImage: ,
                        ),
                    title: Text(doc['name']),
                    subtitle: Text(doc['message']),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MesajlarDetay();
                      }));
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
