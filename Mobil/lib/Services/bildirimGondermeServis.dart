import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

final Firestore _firestore = Firestore.instance;

class BildirimGondermServis {
  Future<bool> bildirimGonder(
      String mesaj, String userid, String token, String adSoyad) async {
    String endURL = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAAQoTdCAg:APA91bGFf39nH2iNJqmDya_n_hjmM5OjOZstQUAn76RhwEQ5OnDhJc05cfYmiLxRc-pqdxRED0m4sCtOYSKbcJy-4jvJnhIs6GoFh6zx36xm2JRnQP5iZDB3n6kOJYDwW7_ZB2NkWP0x";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "key=$firebaseKey"
    };

    String json =
        '{ "to" : "$token", "data" : { "message" : "$mesaj", "title" : "$adSoyad" } }';

    http.Response response =
        await http.post(endURL, headers: headers, body: json);

    if (response.statusCode == 200) {
      String saat, dakika,time;
      saat = DateTime.now().hour.toString();
      dakika = DateTime.now().minute.toString();
      time = saat+ ":" +dakika;
      _firestore
          .collection("bildirim")
          .document("$userid")
          .collection("notes")
          .add({"note": "$adSoyad size mesaj gönderdi",
          "time": time});
    } else {
      print("bir hata oluştu: " + response.statusCode.toString());
      print("jsonumuz : " + json);
    }
  }
  
  Future<bool> bildirimGonderr(String userid, String token, String adSoyad)async{
    String endURL = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAAQoTdCAg:APA91bGFf39nH2iNJqmDya_n_hjmM5OjOZstQUAn76RhwEQ5OnDhJc05cfYmiLxRc-pqdxRED0m4sCtOYSKbcJy-4jvJnhIs6GoFh6zx36xm2JRnQP5iZDB3n6kOJYDwW7_ZB2NkWP0x";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "key=$firebaseKey"
    };

    String json =
        '{ "to" : "$token", "data" : { "message" : "$adSoyad kişisi size puan verdi",} }';

    http.Response response =
        await http.post(endURL, headers: headers, body: json);

    if (response.statusCode == 200) {
      String saat, dakika,time;
      saat = DateTime.now().hour.toString();
      dakika = DateTime.now().minute.toString();
      time = saat+ ":" +dakika;
      _firestore
          .collection("bildirim")
          .document("$userid")
          .collection("notes")
          .add({"note": "$adSoyad size puan verdi",
          "time": time});
    } else {
      print("bir hata oluştu: " + response.statusCode.toString());
      print("jsonumuz : " + json);
    }
  }
   
      

      
}
