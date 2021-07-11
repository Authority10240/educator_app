import 'package:flutter/material.dart';
class ChildInformaiton{


  int id;
  String STUDENT_NUMBER;
  String STUDENT_NAME;
  String STUDENT_SURNAAME;
  Color  itemColor = Colors.blueAccent;
  String SUBJECT_ID;
  String itemString = 'Add';

  ChildInformaiton.blank();

  ChildInformaiton(this.STUDENT_NUMBER,this.STUDENT_NAME,this.STUDENT_SURNAAME,
      this.SUBJECT_ID){
    this.itemColor = Colors.blueAccent;
  }

  ChildInformaiton.withId(this.id, this.STUDENT_NUMBER,this.STUDENT_NAME,
      this.STUDENT_SURNAAME,this.SUBJECT_ID);


  //convert from list to map
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if ( id != null ) {
      map['id'] = id;
    }
      map['STUDENT_NUMBER'] = STUDENT_NUMBER;
      map['STUDENT_NAME'] = STUDENT_NAME;
      map['SUBJECT_ID'] = SUBJECT_ID;
      map['STUDENT_SURNAME'] = STUDENT_SURNAAME;

      return map;
  }

  //extract a child object from the Map object
  ChildInformaiton.fromMapObject(Map<String ,dynamic> map){
    this.id = map['id'];
    this.SUBJECT_ID = map['SUBJECT_ID'];
    this.STUDENT_SURNAAME = map['STUDENT_SURNAME'];
    this.STUDENT_NAME = map['STUDENT_NAME'];
    this.STUDENT_NUMBER = map['STUDENT_NUMBER'];
  }

  String getSUBJECT_ID(){
    return SUBJECT_ID;}

  setSUBJECT_ID(String value) {
    SUBJECT_ID = value;
  }

  String getSTUDENT_SURNAAME () {
    return STUDENT_SURNAAME;
  }

  setSTUDENT_SURNAAME(String value) {
    STUDENT_SURNAAME = value;
  }

  String getSTUDENT_NAME () {
    return STUDENT_NAME;
  }

  setSTUDENT_NAME(String value) {
    STUDENT_NAME = value;
  }

  String getSTUDENT_NUMBER() {
    return STUDENT_NUMBER;
  }

  setSTUDENT_NUMBER(String value) {
    STUDENT_NUMBER = value;
  }

  int getid() {
    return id;
  }

  setid(int value) {
    id = value;
  }


}