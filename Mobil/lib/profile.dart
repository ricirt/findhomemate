import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'Widgets/features.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

List<Features> ozellik;

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    ozellik = [
      Features(true, true, false, true),
      Features(true, false, true, true),
      Features(true, true, false, true),
      Features(false, false, true, false),
      Features(true, true, true, true),
      Features(true, true, false, false),
      Features(false, true, true, true),
      Features(true, false, false, true),
      Features(true, true, false, true),
      Features(false, true, false, false),
      Features(true, false, false, true),
    ];

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatelessWidget {
  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            SizedBox(
              height: 16,
            ),
            Text(
              "Email",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            Text("addidagli@gmail.com"),
            SizedBox(
              height: 16,
            ),
            Text(
              "Konum",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            Text("Büyükdere, Eskişehir"),
            Divider(
              height: 5,
              color: Colors.grey,
            ),
            SizedBox(height: 10,),
            Center(
              child: Text("Kriterler",style: TextStyle(fontSize: 24),),
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              Row(
              children: <Widget>[
                Text(
                  "Sigara",
                  style: _style(),
                ),
                Icon(ozellik[1].sigara == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),

            Row(
              children: <Widget>[
                Text(
                  "Alkol",
                  style: _style(),
                ),
                Icon(ozellik[1].alkol == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Evcil Hayvan",
                  style: _style(),
                ),
                Icon(ozellik[1].evcilHayvan == true
                    ? Icons.check
                    : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Cinsiyet",
                  style: _style(),
                ),
                Icon(ozellik[1].cinsiyet == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            ],),
            SizedBox(
              height: 4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              Row(
              children: <Widget>[
                Text(
                  "Din",
                  style: _style(),
                ),
                Icon(ozellik[3].sigara == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),

            Row(
              children: <Widget>[
                Text(
                  "Politika",
                  style: _style(),
                ),
                Icon(ozellik[3].alkol == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Matematik",
                  style: _style(),
                ),
                Icon(ozellik[3].evcilHayvan == true
                    ? Icons.check
                    : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Yazılım",
                  style: _style(),
                ),
                Icon(ozellik[3].cinsiyet == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            ],),
            SizedBox(
              height: 4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              Row(
              children: <Widget>[
                Text(
                  "Ofis",
                  style: _style(),
                ),
                Icon(ozellik[2].sigara == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),

            Row(
              children: <Widget>[
                Text(
                  "Teknoloji",
                  style: _style(),
                ),
                Icon(ozellik[2].alkol == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Bilim",
                  style: _style(),
                ),
                Icon(ozellik[2].evcilHayvan == true
                    ? Icons.check
                    : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Random",
                  style: _style(),
                ),
                Icon(ozellik[2].cinsiyet == true ? Icons.check : Icons.cancel),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            ],),
            
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

final String url =
    "https://pbs.twimg.com/profile_images/1197914578958651392/goaSDVjl_400x400.jpg";

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 20, offset: Offset(0, 0))
        ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(url))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Alaattin Dağlı",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Yaş",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "23",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Puan",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    Text(
                      "4.5/5",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Oylayan",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "4",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                ),
                SizedBox(
                  width: 32,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text("",
                        style: TextStyle(color: Colors.white, fontSize: 24))
                  ],
                ),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/editProfile");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
                  child: Transform.rotate(
                    angle: (math.pi * 0.05),
                    child: Container(
                      width: 110,
                      height: 32,
                      child: Center(
                        child: Text("Profili Düzenle"),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 20)
                          ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
