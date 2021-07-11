import 'package:flutter/material.dart';
class messageInformation {
  int _id = 0;

  String _ARRIVAL_DATE = 'ARRIVAL_DATE';
  String _DEVICE_ID = 'DEVICE_ID';
  String _MESSAGE_CONTENT = 'MESSAGE_CONTENT';
  String _MESSAGE_HEADING = 'MESSAGE_HEADING';
  String _MESSAGE_ID = 'MESSAGE_ID';
  String _SUBJECT_ID = 'SUBJECT_ID';
  String _ATTACHMENT_ID = 'ATTACHEMENT_ID';
  String _EXTENTION = 'EXTENTION';
  String _NEW_MESSAGE = 'NEW_MESSAGE';
  String _SCHOLAR_YEAR = "SCHOLAR_YEAR";
  String _MESSAGE_PRIORITY = 'MESSAGE_PRIORITY';
  String _SET_ID = 'SET_ID';
  Color messageColor = Colors.blueAccent;


  messageInformation(this._id, this._ARRIVAL_DATE, this._DEVICE_ID,
      this._MESSAGE_CONTENT, this._MESSAGE_HEADING, this._MESSAGE_ID,
      this._SUBJECT_ID, this._ATTACHMENT_ID, this._EXTENTION, this._NEW_MESSAGE,
      this._SCHOLAR_YEAR, this._MESSAGE_PRIORITY, this._SET_ID);

  messageInformation.announ(this._ARRIVAL_DATE,this._MESSAGE_CONTENT,this._MESSAGE_ID);

  messageInformation.blank();

  String get SET_ID => _SET_ID;

  set SET_ID(String value){
    _SET_ID = value;
  }
  String get SCHOLAR_YEAR => _SCHOLAR_YEAR;

  set SCHOLAR_YEAR(String value) {
    _SCHOLAR_YEAR = value;
  }

  String get ARRIVAL_DATE => _ARRIVAL_DATE;

  String get MESSAGE_PRIORITY => _MESSAGE_PRIORITY;

  set MESSAGE_PRIORITY(String value) {
    _MESSAGE_PRIORITY = value;
  }

  String get NEW_MESSAGE => _NEW_MESSAGE;

  set NEW_MESSAGE(String value) {
    _NEW_MESSAGE = value;
  }

  String get EXTENTION => _EXTENTION;

  set EXTENTION(String value) {
    _EXTENTION = value;
  }

  String get ATTACHMENT_ID => _ATTACHMENT_ID;

  set ATTACHMENT_ID(String value) {
    _ATTACHMENT_ID = value;
  }

  String get SUBJECT_ID => _SUBJECT_ID;

  set SUBJECT_ID(String value) {
    _SUBJECT_ID = value;
  }

  String get MESSAGE_ID => _MESSAGE_ID;

  set MESSAGE_ID(String value) {
    _MESSAGE_ID = value;
  }

  String get MESSAGE_HEADING => _MESSAGE_HEADING;

  set MESSAGE_HEADING(String value) {
    _MESSAGE_HEADING = value;
  }

  String get MESSAGE_CONTENT => _MESSAGE_CONTENT;

  set MESSAGE_CONTENT(String value) {
    _MESSAGE_CONTENT = value;
  }

  String get DEVICE_ID => _DEVICE_ID;

  set DEVICE_ID(String value) {
    _DEVICE_ID = value;
  }

  set ARRIVAL_DATE(String value) {
    _ARRIVAL_DATE = value;
  }
// include student id into this table


  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if ( _id != null ) {
      map['id'] = _id;
    }
    map['ARRIVAL_DATE'] = this.ARRIVAL_DATE;
    map['DEVICE_ID'] = this.DEVICE_ID ;
    map['SUBJECT_ID'] = this.SUBJECT_ID ;
    map['MESSAGE_CONTENT'] = this.MESSAGE_CONTENT;
    map['MESSAGE_HEADING'] = this.MESSAGE_HEADING;
    map['MESSAGE_ID'] = this.MESSAGE_ID;
    map['SUBJECT_ID'] = this.SUBJECT_ID;
    map['ATTACHMENT_ID'] = this.ATTACHMENT_ID;
    map['EXTENTION'] = this.EXTENTION;
    map['NEW_MESSAGE'] = this.NEW_MESSAGE;
    map['MESSAGE_PRIORITY'] = this.MESSAGE_PRIORITY;

    return map;
  }


  //extract a child object from the Map object
  messageInformation.fromMapObject(Map<String ,dynamic> map){
    this._id = map['id'];
    this.ARRIVAL_DATE = map['ARRIVAL_DATE'];
    this.DEVICE_ID = map['DEVICE_ID'];
    this.SUBJECT_ID = map['SUBJECT_ID'];
    this.MESSAGE_CONTENT = map['MESSAGE_CONTENT'];
    this.MESSAGE_HEADING = map['MESSAGE_HEADING'];
    this.MESSAGE_ID = map['MESSAGE_ID'];
    this.SUBJECT_ID = map['SUBJECT_ID'];
    this.ATTACHMENT_ID = map['ATTACHMENT_ID'];
    this.EXTENTION = map['EXTENTION'];
    this.NEW_MESSAGE = map['NEW_MESSAGE'];
    this.MESSAGE_PRIORITY = map['MESSAGE_PRIORITY'];
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

}