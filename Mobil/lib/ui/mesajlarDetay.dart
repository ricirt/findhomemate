import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MesajDetay extends StatefulWidget {
  final String conversationid;
  final String aliciID;
  const MesajDetay({Key key, this.conversationid, this.aliciID})
      : super(key: key);

  @override
  _MesajDetayState createState() => _MesajDetayState();
}

class _MesajDetayState extends State<MesajDetay> {
  final TextEditingController _editingController = TextEditingController();
  CollectionReference _ref,_ref2;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  void initState() {
    _ref =
        Firestore.instance.collection('chat/${widget.conversationid}/yeni/${widget.aliciID}/messages');
        _ref2 = Firestore.instance.collection('chat/${widget.aliciID}/yeni/${widget.conversationid}/messages');
    super.initState();
    _addMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/1197914578958651392/goaSDVjl_400x400.jpg")),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Alaattin Dağlı"),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: _ref.orderBy('timeStamp').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return !snapshot.hasData
                      ? CircularProgressIndicator()
                      : ListView(
                          children: snapshot.data.documents
                              .map(
                                (document) => ListTile(
                                  title: Align(
                                    alignment: //widget.conversationid !=
                                            //document['senderid']
                                       //? Alignment.centerLeft :
                                         Alignment.centerRight,
                                    child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(10),
                                                    right:
                                                        Radius.circular(10))),
                                        child: Text(
                                          document['message'],
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                }),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(25))),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Icon(
                            Icons.tag_faces,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _editingController,
                          decoration: InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await _ref.add({
                      'senderid': widget.conversationid,
                      'message': _editingController.text,
                      'timeStamp': DateTime.now(),
                    });
                      await _ref2.add({
                      'aliciID': widget.aliciID,
                      'message': _editingController.text,
                      'timeStamp': DateTime.now(),
                    });
                    _editingController.text = "";
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _addMembers() async {
    _firestore.collection("chat")
    .document("${widget.conversationid}")
    .collection("yeni")
    .document("${widget.aliciID}")
    .setData({
      "members": [widget.conversationid, widget.aliciID],
    },merge: true);

     _firestore.collection("chat")
    .document("${widget.aliciID}")
    .collection("yeni")
    .document("${widget.conversationid}")
    .setData({
      "members": [widget.conversationid, widget.aliciID],
    },merge: true);
     
  }
}
