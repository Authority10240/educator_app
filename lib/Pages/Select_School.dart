import 'dart:ui';

import 'package:educator_app/BackEnd/Strings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:educator_app/Models/School_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/Pages/SplashScreen.dart';

import "package:sqflite/sqflite.dart";



class School_Select extends StatefulWidget {
  @override
  String _name = '' , _surname = '' , _studentNumber = '';


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  School_Select();

  _School_SelectState createState() => _School_SelectState(_name,_surname,_studentNumber);

  get surname => _surname;

  set surname(value) {
    _surname = value;
  }

  get studentNumber => _studentNumber;

  set studentNumber(value) {
    _studentNumber = value;
  }
}

class _School_SelectState extends State<School_Select> {
  String _name = '' , _surname = '' , _studentNumber = '';
  SharedPreferences sp;
  _School_SelectState(this._name, this._surname, this._studentNumber);

  @override
  List<school_model> school_names;




  Widget build(BuildContext context) {
    // TODO: implement build

    if (school_names == null){
      school_names = new List();
      UpdateListView();
    }

    return Scaffold(appBar:
    AppBar(centerTitle: true,
    title: Text('Select School',style: TextStyle(color: Colors.white),),),
    body: ListView.builder(itemCount: school_names.length,itemBuilder: ( context , pos) =>
    new Column(
      children: <Widget>[
        GestureDetector( child: ListTile(leading:
        new CircleAvatar(

          child: Image.network(school_names[pos].school_logo),
          backgroundColor: Colors.cyan,)
          ,title: Text(school_names[pos].school_name),),
        onTap: ()async{
          String schoolName = school_names[pos].school_name;
          String schoolLogo = school_names[pos].school_logo;
          sp = await SharedPreferences.getInstance();

          sp.setString('SCHOOL_NAME', schoolName);
          sp.setString('SCHOOL_LOGO', schoolLogo);

          Strings.insertSchool(schoolName, schoolLogo);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));


        },

        ),

        Divider(height: 10,)
      ],
    )),);
  }

  UpdateListView(){
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('REGISTERED_SCHOOLS').onChildAdded.listen((event){
      var val = event.snapshot.value;
      setState(() {
        school_names.add(school_model(val['SCHOOL_NAME'], val['SCHOOL_LOGO']));
      });

    });

  }
}
