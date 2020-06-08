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
  CollectionReference _ref, _ref2;
  final Firestore _firestore = Firestore.instance;
  String adSoyad;
  String profilResmi;

  @override
  void initState() {
    debugPrint("conversation id ${widget.conversationid}");
    debugPrint("conversation id ${widget.aliciID}");
    _ref = Firestore.instance.collection(
        'chat/${widget.conversationid}/yeni/${widget.aliciID}/messages');
    _ref2 = Firestore.instance.collection(
        'chat/${widget.aliciID}/yeni/${widget.conversationid}/messages');
    super.initState();
    _addMembers();
    _getInfo();
      }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right :8.0),
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          profilResmi)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(adSoyad),
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
                                        alignment: widget.conversationid !=
                                                    document['senderid'] &&
                                                widget.aliciID !=
                                                    document['aliciID']
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
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
                          'aliciID': widget.aliciID,
                          'message': _editingController.text,
                          'timeStamp': DateTime.now(),
                        });
                        await _ref2.add({
                          'senderid': widget.conversationid,
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
        final snapShot = await Firestore.instance
            .collection('chat')
            .document("${widget.conversationid}")
            .get();
    
        final snapShot2 = await Firestore.instance
            .collection('chat')
            .document("${widget.aliciID}")
            .get();
    
            debugPrint("snapshot exist : "+snapShot.exists.toString());
          debugPrint("snapshot null : "+snapShot.toString());
    
        if (snapShot != null) {
          
          _firestore
              .collection("chat")
              .document("${widget.conversationid}")
              .collection("yeni")
              .document("${widget.aliciID}")
              .setData({
            "members": [widget.conversationid, widget.aliciID],
          }, merge: true);
        }
    
        debugPrint("snapshot exist 2 : "+snapShot2.exists.toString());
          debugPrint("snapshot null 2 : "+snapShot2.toString());
        if (snapShot2 != null) {
          _firestore
              .collection("chat")
              .document("${widget.aliciID}")
              .collection("yeni")
              .document("${widget.conversationid}")
              .setData({
            "members": [widget.conversationid, widget.aliciID],
          }, merge: true);
        }
      }
    
      void _getInfo() async {
          DocumentSnapshot documentSnapshot =
        await _firestore.document("kullanicilar/${widget.aliciID}").get();

    setState(() {
      adSoyad = documentSnapshot.data['adSoyad'];
      profilResmi = documentSnapshot.data['profilResmi'];
     
    });
      }
}
