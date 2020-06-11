import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print("arka planda gelen data : " + message['data'].toString());
    NotificationHandler.showNotification(message);
  }
/*
  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
*/
  return Future<void>.value();
}

class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();

  static final NotificationHandler _singleton = NotificationHandler._internal();
  factory NotificationHandler() {
    return _singleton;
  }
  NotificationHandler._internal();

  initializeFCMNotification(BuildContext context) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    /*
     _fcm.subscribeToTopic("all");

     String token  = await _fcm.getToken();
     print("token : "+ token);
*/

    _fcm.onTokenRefresh.listen((newToken) async {
      FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
      await Firestore.instance
          .document("tokens/" + _currentUser.uid)
          .setData({"token": newToken});
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showNotification(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  static void showNotification(Map<String, dynamic> message) async {
    //var userURLPath =
    /* await _downloadAndSaveImage(message["data"]["profilURL"], 'largeIcon');

    var mesaj = Person(
        name: message["data"]["title"],
        key: '1',
        //icon: userURLPath,
        iconSource: IconSource.FilePath);
    var mesajStyle = MessagingStyleInformation(mesaj,
        messages: [Message(message["data"]["message"], DateTime.now(), mesaj)]);*/

    print("showNotificationnnn girdi");

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1234', 'Yeni Mesaj', 'your channel description',
        //style: AndroidNotificationStyle.Messaging,
        //styleInformation: mesajStyle,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message["data"]["title"],
        message["data"]["message"], platformChannelSpecifics,
        payload: "heh he ");
    print("showNotificationnnn çıktı");
  }

  Future onSelectNotification(String payload) async {
    print("onSelectNotification girdi");

    if (payload != null) {
      debugPrint('notification payload: ' + payload);

      /*Map<String, dynamic> gelenBildirim = await jsonDecode(payload);

      Navigator.of(myContext, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            builder: (context) => ChatViewModel(
                currentUser: _userModel.user,
                sohbetEdilenUser: User.idveResim(
                    userID: gelenBildirim["data"]["gonderenUserID"],
                    profilURL: gelenBildirim["data"]["profilURL"])),
            child: SohbetPage(),
          ),
        ),
      );*/
      print("onSelectNotification çıktı");
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    print("onDidReceiveLocalNotification girdi");
    print("onDidReceiveLocalNotification çıktı");
  }

  /*static _downloadAndSaveImage(String url, String name) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$name';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }*/

}
