import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: Text("",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil.getInstance().setSp(26))),
        ),
        Container(
          width:  double.infinity /2,
          height: MediaQuery.of(context).size.height/12,
          color: Colors.white70,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0)),
          ),
        ),
        Container(
          child: Text("",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil.getInstance().setSp(26))),
        ),
        Container(
          width:  double.infinity /2,
          height: MediaQuery.of(context).size.height/12,
          color: Colors.white70,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: "Şifre",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0)),
          ),
        ),
      ],
    );
  }
}
