import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/ui/loading.dart';
import 'package:flutter/material.dart';
import 'package:deneme/Services/bildirimGondermeServis.dart';

class MesajDetay extends StatefulWidget {
  final String conversationid;
  final String aliciID;
  const MesajDetay({Key key, this.conversationid, this.aliciID})
      : super(key: key);

  @override
  _MesajDetayState createState() => _MesajDetayState();
}

bool loading;

class _MesajDetayState extends State<MesajDetay> {
  BildirimGondermServis _bildirimGondermeServis = BildirimGondermServis();
  final TextEditingController _editingController = TextEditingController();
  CollectionReference _ref, _ref2;
  final Firestore _firestore = Firestore.instance;
  String adSoyad;
  String profilResmi;
  String benAdSoyad;
  String benProfilResmi;
  String lastMessage;
  String lastMessageTime;
  Map<String, String> kullaniciToken = Map<String, String>();

  @override
  void initState() {
    loading = true;
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
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(profilResmi)),
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
                      stream: _ref.orderBy('time').snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return (!snapshot.hasData ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
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
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                          left: Radius.circular(
                                                              10),
                                                          right:
                                                              Radius.circular(
                                                                  10))),
                                              child: Text(
                                                document['message'],
                                                style: TextStyle(
                                                    color: Colors.white),
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
                          String saat, dakika;
                          saat = DateTime.now().hour.toString();
                          dakika = DateTime.now().minute.toString();
                          lastMessageTime = saat + ":" + dakika;
                          _addFeatures();

                          await _ref.add({
                            'senderid': widget.conversationid,
                            'aliciID': widget.aliciID,
                            'message': _editingController.text,
                            'time': DateTime.now(),
                          });

                          lastMessage = _editingController.text;
                          await _ref2.add({
                            'senderid': widget.conversationid,
                            'aliciID': widget.aliciID,
                            'message': _editingController.text,
                            'time': DateTime.now(),
                          });
                          _editingController.text = "";

                          var token = "";
                          if (kullaniciToken.containsKey(widget.aliciID)) {
                            token = kullaniciToken[widget.aliciID];
                            print("Localden geldi : " + token);
                          } else {
                            print("else girdim");
                            token = await tokenGetir(widget.aliciID);
                            if (token != null)
                              kullaniciToken[widget.aliciID] = token;
                            print("Veritabanından geldi : " + token);
                          }
                          if (token != null) {
                            print("girdi");
                            await _bildirimGondermeServis.bildirimGonder(
                                lastMessage, widget.aliciID, token, benAdSoyad);
                            print("çıktı");
                          }
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

    debugPrint("snapshot exist : " + snapShot.exists.toString());
    debugPrint("snapshot null : " + snapShot.toString());

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

    debugPrint("snapshot exist 2 : " + snapShot2.exists.toString());
    debugPrint("snapshot null 2 : " + snapShot2.toString());
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

    DocumentSnapshot documentSnapshot2 = await _firestore
        .document("kullanicilar/${widget.conversationid}")
        .get();

    setState(() {
      benAdSoyad = documentSnapshot2.data['adSoyad'];
      benProfilResmi = documentSnapshot2.data['profilResmi'];
    });
    debugPrint("alici id : ${widget.aliciID}");
    debugPrint("conversa id : ${widget.conversationid}");

    debugPrint("ad : " + adSoyad);
    debugPrint("ben ad : " + benAdSoyad);
    loading = false;
  }

  void _addFeatures() async {
    final snapShot = await Firestore.instance
        .collection('chat')
        .document("${widget.conversationid}")
        .get();

    final snapShot2 = await Firestore.instance
        .collection('chat')
        .document("${widget.aliciID}")
        .get();

    if (snapShot != null) {
      _firestore
          .collection("chat")
          .document("${widget.conversationid}")
          .collection("yeni")
          .document("${widget.aliciID}")
          .setData({
        "adSoyad": adSoyad,
        "profilResmi": profilResmi,
        "lastMessage": lastMessage,
        "lastMessageTime": lastMessageTime,
      }, merge: true);
    }

    if (snapShot2 != null) {
      _firestore
          .collection("chat")
          .document("${widget.aliciID}")
          .collection("yeni")
          .document("${widget.conversationid}")
          .setData({
        "adSoyad": benAdSoyad,
        "profilResmi": benProfilResmi,
        "lastMessage": lastMessage,
        "lastMessageTime": lastMessageTime,
      }, merge: true);
    }
  }

  Future<String> tokenGetir(String aliciID) async {
    DocumentSnapshot _token =
        await _firestore.document("tokens/" + aliciID).get();
    if (_token != null)
      return _token.data['token'].toString();
    else
      return null;
  }
}
