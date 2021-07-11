class FirebaseMessage{

  String _id ;

  String _ARRIVAL_DATE = 'ARRIVAL_DATE';
  String _DEVICE_ID = 'DEVICE_ID';
  String _MESSAGE_CONTENT = 'MESSAGE_CONTENT';
  String _MESSAGE_HEADING = 'MESSAGE_HEADING';
  String _MESSAGE_ID = 'MESSAGE_ID';
  String _SUBJECT_ID = 'SUBJECT_ID';
  String _ATTACHMENT_ID = 'ATTACHEMENT_ID';
  String _EXTENTION = 'EXTENTION';
  String _NEW_MESSAGE = 'NEW_MESSAGE';
  String _MESSAGE_PRIORITY = 'MESSAGE_PRIORITY';

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get ARRIVAL_DATE => _ARRIVAL_DATE;

  FirebaseMessage( this._ARRIVAL_DATE, this._DEVICE_ID,
      this._MESSAGE_CONTENT, this._MESSAGE_HEADING, this._MESSAGE_ID,
      this._SUBJECT_ID, this._ATTACHMENT_ID, this._EXTENTION, this._NEW_MESSAGE,
      this._MESSAGE_PRIORITY){
    id = ATTACHMENT_ID + DEVICE_ID + SUBJECT_ID;
  }

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

}