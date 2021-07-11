import 'package:flutter/material.dart';

class NoAuthority extends StatefulWidget {
  @override
  _NoAuthorityState createState() => _NoAuthorityState();
}

class _NoAuthorityState extends State<NoAuthority> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Authority Revoked",
      style: TextStyle(color: Colors.white),),
      backgroundColor:Colors.blueAccent ,),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[

            SizedBox(height: 200,),
            Center(child: Icon(Icons.block, color: Colors.red , size: 75,),),
            Center(child: Text("Your Account has been revoked, please contact school admin."),),
          ],
        ),

      ),);
  }
}
