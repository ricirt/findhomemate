import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/ui/mesajlarDetay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mesajlar extends StatefulWidget {
  const Mesajlar({Key key}) : super(key: key);

  @override
  _MesajlarState createState() => _MesajlarState();
}
  
class _MesajlarState extends State<Mesajlar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  String userid;

  List<String> userList = List();

  @override
  void initState() {
    super.initState();
    _getID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mesajlar"),
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          //Fire baseye messaages bolumu eklendıkten sonra revize edilecek.
          
          stream: Firestore.instance
              .collection('chat')
              .document('$userid')
              .collection('yeni')
              .orderBy("lastMessageTime",descending: true)
              .snapshots(),
              
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            /// eger snapshotta hata varsa
            
            if ( snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
              /// Gif koyulabılır
              return Center(child: CircularProgressIndicator(),);
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
                                doc['profilResmi'] == null ? "" : doc['profilResmi']),
                          ),
                          title: Text(doc['adSoyad'] == null ? "" : doc['adSoyad']),
                          subtitle: Text(doc['lastMessage'] == null ? "" : doc['lastMessage'] ),
                          trailing: Column(
                            children: <Widget>[
                              Text(doc['lastMessageTime']),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).accentColor),
                                child: Center(
                                  child: Text(
                                    "2",
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            debugPrint("userid : " + userid);
                            debugPrint("document id :" + doc.documentID);
                        

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return MesajDetay(
                                conversationid: userid,
                                aliciID: doc.documentID,
                              );
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

  void _getID() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.uid;

    if (user != null) {
      DocumentSnapshot documentSnapshot =
          await _firestore.document("kullanicilar/$uid").get();

      setState(() {
        userid = documentSnapshot.data['uid'].toString();
      });

      var dokumanlar = await _firestore
          .collection("chat")
          .document("$uid")
          .collection("yeni")
          .getDocuments();

      for (var dokuman in dokumanlar.documents) {
        if (uid != dokuman.data["members"][0].toString()) {
          if (!userList.contains(dokuman.data["members"][0].toString())) {
            userList.add(dokuman.data["members"][0].toString());
          }
        } else {
          if (!userList.contains(dokuman.data["members"][1].toString())) {
            userList.add(dokuman.data["members"][1].toString());
          }

        }
      }
    }
  }
}
