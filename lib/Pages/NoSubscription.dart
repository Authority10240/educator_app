import 'package:flutter/material.dart';

class NoSubScritption extends StatefulWidget {
  @override
  _NoSubScritptionState createState() => _NoSubScritptionState();
}

class _NoSubScritptionState extends State<NoSubScritption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Subscription Overdue",
      style: TextStyle(color: Colors.white),),
      backgroundColor:Colors.blueAccent ,),
    body: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[

          SizedBox(height: 200,),
          Center(child: Icon(Icons.block, color: Colors.red , size: 75,),),
          Center(child: Text("School Subscription expired. Please request a license renewal"),),
        ],
      ),

    ),);
  }
}
