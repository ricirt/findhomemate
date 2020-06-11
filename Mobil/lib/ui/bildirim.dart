import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/ui/ilanVer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Bildirim extends StatefulWidget {
  @override
  BildirimState createState() {
    return new BildirimState();
  }
}

class BildirimState extends State<Bildirim> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  String userid;

  @override
  void initState() {
    super.initState();
    _getID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bildirimler"),
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          //Fire baseye messaages bolumu eklendıkten sonra revize edilecek.

          stream: Firestore.instance
              .collection('bildirim')
              .document('$userid')
              .collection('notes')
              .snapshots(),

          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            /// eger snapshotta hata varsa

            if (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.waiting) {
              /// Gif koyulabılır
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            double c_width = MediaQuery.of(context).size.width * 0.8;
            return ListView(
              children: snapshot.data.documents
                  .map((doc) => Card(
                    margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Container(
                            padding: const EdgeInsets.all(8.0),
                            width: c_width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(doc['time'] == null ? "" : doc['time'],
                                    textAlign: TextAlign.left),
                                    Divider(
                                      indent: 2,
                                      color: Colors.grey,
                                    ),
                                Text(doc['note'] == null ? "" : doc['note'],
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Future _getID() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid").get();

      setState(() {
        userid = documentSnapshot.data['uid'].toString();
      });
    }
  }
}
