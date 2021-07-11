import 'package:educator_app/BackEnd/Strings.dart';
import 'package:flutter/material.dart';
class ContactInformation{

  int _id;
  String _TEACHER_ID ;
  String _SUBJECT_TABLE ;
  String _DEPARTMENT_ID ;
  String _COURSE_ID;
  String _SUBJECT_ID;
  String _TEACHER_NAME;
  String _STUDENT_NUMBER;
  String _SET_ID;
  Color itemColor = Colors.green;
  String itemString = 'Add';
  String optionSelect = 'Select';


  String get STUDENT_NUMBER => _STUDENT_NUMBER;

  set STUDENT_NUMBER(String value) {
    _STUDENT_NUMBER = value;
  }

  ContactInformation.blank();


  ContactInformation(this._COURSE_ID, this._SUBJECT_ID,this._SET_ID);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get SET_ID => _SET_ID;

  set SET_ID(String value){
    _SET_ID = value;
  }
  String get TEACHER_ID => _TEACHER_ID;

  String get TEACHER_NAME => _TEACHER_NAME;

  set TEACHER_NAME(String value) {
    _TEACHER_NAME = value;
  }

  String get SUBJECT_ID => _SUBJECT_ID;

  set SUBJECT_ID(String value) {
    _SUBJECT_ID = value;
  }

  String get COURSE_ID => _COURSE_ID;

  set COURSE_ID(String value) {
    _COURSE_ID = value;
  }

  String get DEPARTMENT_ID => _DEPARTMENT_ID;

  set DEPARTMENT_ID(String value) {
    _DEPARTMENT_ID = value;
  }

  String get SUBJECT_TABLE => _SUBJECT_TABLE;

  set SUBJECT_TABLE(String value) {
    _SUBJECT_TABLE = value;
  }

  set TEACHER_ID(String value) {
    _TEACHER_ID = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if ( _id != null ) {
      map['id'] = _id;
    }
    map['TEACHER_ID'] = Strings.EMPLOYEE_NUMBER;
    map['TEACHER_NAME'] = Strings.TEACHER_NAME;
    map['SUBJECT_ID'] = this.SUBJECT_ID;
    map['COURSE_ID'] = this.COURSE_ID;
    map['DEPARTMENT_ID'] = this.DEPARTMENT_ID;
    map['STUDENT_NUMBER'] = this.STUDENT_NUMBER;
    map['SET_ID'] = this.SET_ID;

    return map;
  }

  //extract a child object from the Map object
  ContactInformation.fromMapObject(Map<String ,dynamic> map){
    this._id = map['id'];
    this.TEACHER_ID =  map['TEACHER_ID'];
    this.TEACHER_NAME = map['TEACHER_NAME'] ;
    this.SUBJECT_ID = map['SUBJECT_ID'] ;
    this.COURSE_ID =  map['COURSE_ID'] ;
    this.DEPARTMENT_ID =  map['DEPARTMENT_ID'] ;
    this.STUDENT_NUMBER = map['STUDENT_NUMBER'];
    this.SET_ID = map['SET_ID'];
  }



}