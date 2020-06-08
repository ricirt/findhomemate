import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/ui/mesajlarDetay.dart';
import 'package:flutter/material.dart';

class Mesajlar extends StatelessWidget {
  const Mesajlar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mesajlar",textAlign: TextAlign.center,),
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          //Fire baseye messaages bolumu eklendıkten sonra revize edilecek.
          stream: Firestore.instance.collection('mesajlar').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  .map((doc) => Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            //Mesajlaşılanın kişinin fotografı
                            backgroundImage: NetworkImage(
                                "https://pbs.twimg.com/profile_images/1197914578958651392/goaSDVjl_400x400.jpg"),
                          ),
                          title: Text(doc['ad']),
                          subtitle: Text(doc['mesaj']),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return MesajlarDetay();
                            }));
                          },
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
