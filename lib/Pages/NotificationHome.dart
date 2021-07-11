import 'package:educator_app/BackEnd/Strings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:educator_app/SQL_Models/message_model.dart';

class NotificationHome extends StatefulWidget {
  @override
  _NotificationHomeState createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  DatabaseReference databaseReference;
  List<messageInformation> announcements ;

  @override

  Widget build(BuildContext context) {
    // TODO implement build

    if(announcements == null){
      announcements = new List();
      getAnnouncements();
    }
    return
    Scaffold(

      body: ListView.builder(itemCount: announcements.length,itemBuilder: (BuildContext context , int pos){
        return Card(
          color: Colors.white,
          elevation: 7.0,
          child: ListTile(
            onTap: (){
              
            },
            title: Text(announcements[pos].MESSAGE_CONTENT),
            subtitle: Text(announcements[pos].ARRIVAL_DATE),
          ),
        );
      }),
    );
  }

  getAnnouncements(){
    messageInformation announ = new messageInformation.blank();
    databaseReference = FirebaseDatabase.instance.reference()
        .child(Strings.SCHOOL_NAME).child('ANNOUNCEMENTS');
    databaseReference.onChildAdded.listen((event){
      var val = event.snapshot.value;
try {
  announcements.add(new messageInformation.announ(val['ARRIVAL_DATE'], val['MESSAGE_CONTENT'], val['MESSAGE_ID']));
  setState(() {

  });
}catch(e){
  e.toString();
}




    });
  }


}
