import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ValidateUser extends StatefulWidget {
  @override
  _ValidateUserState createState() => _ValidateUserState();
}

class _ValidateUserState extends State<ValidateUser> {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  listenToSchoolAuth(){
    databaseReference = FirebaseDatabase.instance.reference().child("ClientPassword")
        .child("Password").child("Capricorn High School");
    databaseReference.onChildChanged.listen((event){
      var val = event.snapshot.value();
      String SCHOOL_AUTH = val["Status"];
    });
  }

  listenToIndividualAuth(){

  }
}
