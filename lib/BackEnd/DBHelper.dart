import 'dart:async';
import 'dart:core';
import 'package:educator_app/SQL_Models/child_model.dart';
import 'package:educator_app/SQL_Models/school_model.dart';
import 'package:educator_app/SQL_Models/year_Model.dart';
import 'package:educator_app/SQL_Models/message_model.dart';
import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
class DBHelper {

  /*
   * this is information of the CHILD TABLE
   */
  final String CHILD_TABLE = 'CHILD_TABLE';
  final String STUDENT_NUMBER = 'STUDENT_NUMBER';
  final String STUDENT_NAME = 'STUDENT_NAME';
  final String STUDENT_SURNAAME = 'STUDENT_SURNAME';
  final String SCHOOL_ID = 'SCHOOL_ID'
  ;

  /*
 *this is information for the school table
  */

  final String SCHOOL_TABLE = 'SCHOOL_TABLE';
  final String SCHOOL_NAME = 'SCHOOL_NAME';
  final String SCHOOL_LOCATION = 'SCHOOL_LOCATION';
  final String SCHOOL_EMAIL = 'SCHOOL_EMAIL';
  final String SCHOOL_CONTACTS = 'SCHOOL_CONTACTS';
  final String SCHOOL_PRINCIPAL = 'SCHOOL_PRINCIPAL';

  /*
   * this is information of the message table
   */
  final String MESSAGE_TABLE = 'MESSAGE_TABLE';
  final String ARRIVAL_DATE = 'ARRIVAL_DATE';
  final String DEVICE_ID = 'DEVICE_ID';
  final String MESSAGE_CONTENT = 'MESSAGE_CONTENT';
  final String MESSAGE_HEADING = 'MESSAGE_HEADING';
  final String MESSAGE_ID = 'MESSAGE_ID';
  final String SUBJECT_ID = 'SUBJECT_ID';
  final String ATTACHMENT_ID = 'ATTACHEMENT_ID';
  final String EXTENTION = 'EXTENTION';
  final String NEW_MESSAGE = 'NEW_MESSAGE';
  final String MESSAGE_PRIORITY = 'MESSAGE_PRIORITY';

  // include student id into this table

  // this is for the subject table
  // include student device ID into this table
  final String TEACHER_ID = 'TEACHER_ID';
  final String SUBJECT_TABLE = 'SUBJECT_TABLE';
  final String DEPARTMENT_ID = "DEPARTMENT_ID";
  final String COURSE_ID = 'COURSE_ID';
  final String SET_ID = 'SET_ID';

  //include subject ID in this table
  final String TEACHER_NAME = 'TEACHER_NAME';

  //this is a table for the year a student enters school
  final String YEAR_TABLE = 'YEAR_TABLE';
  final String SCHOLAR_YEAR = 'SCHOLAR_YEAR';
  //include student_Id in this table

  final String SCHOOLAUTHSTATUS = "SCHOOLAUTHSTATUS";
  final String TEACHERAUTHSTATUS = "TEACHERAUTHSTATUS";


  static Database db_instance;


  Future<Database> get db async {
    if (db_instance == null) {
      db_instance = await initDB();
    }

    return db_instance;
  }


  Future<Database> initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Entacom.db');
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc, onUpgrade: onUpGradeFunc) ;

    return db;
  }

  void onUpGradeFunc(Database db, int prev , int late) async{

  }


  void onCreateFunc(Database db, int version) async {
    //child table to store different chidren

    await db.execute(
        'CREATE TABLE $CHILD_TABLE($STUDENT_NUMBER TEXT , $STUDENT_NAME TEXT , '
            '$STUDENT_SURNAAME TEXT , $SCHOOL_ID TEXT, $SUBJECT_ID TEXT , $SET_ID TEXT,'
            ' PRIMARY KEY ($STUDENT_NUMBER, $SUBJECT_ID));');

    //messages table to store messages
    await db.execute(
        'CREATE TABLE $MESSAGE_TABLE( id INTEGER PRIMARY KEY AUTOINCREMENT ,'
            '$ARRIVAL_DATE TEXT, $DEVICE_ID TEXT , $MESSAGE_CONTENT TEXT , '
            '$MESSAGE_HEADING TEXT, $MESSAGE_ID TEXT , $SUBJECT_ID TEXT, $ATTACHMENT_ID TEXT , '
            '$EXTENTION TEXT , $NEW_MESSAGE TEXT ,  $SCHOLAR_YEAR TEXT , $MESSAGE_PRIORITY TEXT'
            ', $SET_ID TEXT );');

    //subject table to store subject information
    await db.execute(
        'CREATE TABLE $SUBJECT_TABLE ('
            '$COURSE_ID TEXT , $SUBJECT_ID TEXT , $SCHOLAR_YEAR TEXT, $SET_ID TEXT, PRIMARY KEY($COURSE_ID , $SUBJECT_ID, $SET_ID) ); ');

    //year table to store years
    await db.execute(
        'CREATE TABLE $YEAR_TABLE ( $SCHOLAR_YEAR TEXT,'
            ' $STUDENT_NUMBER TEXT  , $STUDENT_NAME TEXT , $STUDENT_SURNAAME ,'
            ' $SUBJECT_ID TEXT , PRIMARY KEY($STUDENT_NUMBER , $SUBJECT_ID) );');
    // school table to store schools offline
    await db.execute(
        'CREATE TABLE $SCHOOL_TABLE ( id INTEGER PRIMARY KEY AUTOINCREMENT,'
            ' $SCHOOL_NAME TEXT , $SCHOOL_LOCATION TEXT , $SCHOOL_CONTACTS TEXT ,'
            ' $SCHOOL_EMAIL TEXT , $SCHOOL_PRINCIPAL TEXT );');
  }


////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////BEGINNING OF STUDENT INFORMATION TABLE METHODS//////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  /**
   * Add New Student
   * Adds new student to the database of students with all required information namely:
   * STUDENT_NUMBER
   * STUDENT_NAME
   * STUDENT_SURNAME
   * SCHOOL_ID
   */
  Future<int> addNewStudent(ChildInformaiton childInformation) async {
    Database database = await db;
    childInformation.id = await getChildCount() + 1;
    var result;
    try {
       result = await database.insert(CHILD_TABLE, childInformation.toMap());
    }catch( ex){
      // value already exists
    }
    return result;
  }

  /**
   * updates a particular record on the child database
   */
  Future<int> updateChid(ChildInformaiton childInfo) async {
    var database = await this.db;
    var result = await database.update(
        CHILD_TABLE, childInfo.toMap(), where: '$STUDENT_NUMBER = ?',
        whereArgs: [childInfo.STUDENT_NUMBER]);
    return result;
  }

  Future<int> deleteChild(ChildInformaiton childInfo) async {
    var database = await db;
    int result = await database.delete(
        CHILD_TABLE, where: '$STUDENT_NUMBER = ?',
        whereArgs: [childInfo.STUDENT_NUMBER]);
    return result;
  }

  /**
   * get the count of students
   *
   */

  Future<int> getChildCount() async {
    var database = await db;
    List<Map<String, dynamic>> x = await database.rawQuery(
        'SELECT COUNT(*) FROM $CHILD_TABLE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  /**
   * checks if a particular student has already been added
   */
  Future<bool> CheckUser(ChildInformaiton childInfo) async {
    bool present = false;
    var database = await db;
    List<Map<String, dynamic>> x = await database.rawQuery(
        'SELECT COUNT(*) FROM $CHILD_TABLE WHERE $STUDENT_NUMBER = ? AND $SCHOOL_ID = ?',
        [childInfo.STUDENT_NUMBER, childInfo.SUBJECT_ID]);
    if (x.isNotEmpty) {
      present = true;
    }

    return present;
  }


  /**
   * Gets the students whom have been registered on the device and all required information namely
   * STUDENT_NUMBER
   * STUDENT_NAME
   * STUDENT_SURNAME
   * SCHOOL_ID
   *
   * returns Futur<list<ChildInformation>>
   **/
  Future<List<Map<String, dynamic>>> getStudent(String Subject) async {
    var db_connection = await db;
    var result = await db_connection.query(CHILD_TABLE );
    return result;
  }

  Future<List<Map<String, dynamic>>> getSearchedStudent(String Subject , String StudentNumber) async {
    var db_connection = await db;
    var result = await db_connection.query(CHILD_TABLE , where: '$SUBJECT_ID = ? AND $STUDENT_NUMBER LIKE ?' , whereArgs: [Subject,"%"+StudentNumber+'%']);
    return result;
  }


  /**
   * Helps converts the students list from a Map to a List for the list view
   *
   * from Map<String, dynamic> >> List<ChildInformation>
   */
  Future<List<ChildInformaiton>> getChildrenList(String Subject , String StudentNumber) async {
    var childMapList;
    if(StudentNumber.isEmpty) {
      childMapList = await getStudent(Subject);
    }else{
      childMapList = await getSearchedStudent(Subject , StudentNumber);
    }

    List<ChildInformaiton> childInfo = List<ChildInformaiton>();

    for (int i = 0; i < childMapList.length; i++) {
      childInfo.add(ChildInformaiton.fromMapObject(childMapList[i]));
    }

    return childInfo;
  }

  //////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
/////////////////////////////END OF STUDENT INFORMATION TABLE METHODS//////////
///////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////BEGINNING OF SCHOOL INFORMATION TABLE METOHDS//////////////////
////////////////////////////////////////////////////////////////////////////////

  /**
   * set all the schools that have registered on the admin portal and their information namely
   * SCHOOL_NAME
   * SCHOOL_LOCATION
   * SCHOOL_CONTACTS
   * SCHOOL_EMAIL
   * SCHOOL_PRINCIPAL
   */
  void addNewSchool(SchoolInformation schoolinformation) async {
    var db_connection = await db;
    String query = 'INSERT INTO $SCHOOL_TABLE VALUES(\'${schoolinformation
        .getSCHOOL_NAME()}\''
        ',\'${schoolinformation.SCHOOL_LOCATION}\',\'${schoolinformation
        .SCHOOL_CONTACTS}\''
        ',\'${schoolinformation.SCHOOL_EMAIL}\' ,\' ${schoolinformation
        .SCHOOL_PRINCIPAL}\')';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  /**
   * get all the school registered on the database from the server and saves them as a map file
   * SCHOOL_NAME
   * SCHOOL_LOCATION
   * SCHOOL_CONTACTS
   * SCHOOL_EMAIL
   * SCHOOL_PRINCIPAL
   */

  Future<List<Map<String, dynamic>>> getSchools() async {
    var db_connection = await db;
    var result = await db_connection.query(SCHOOL_TABLE, orderBy: SCHOOL_NAME);
    return result;
  }

  /**
   * helps convert the school list obejct from Map to List for listview
   * from Map<String, dynamic> to List<SchoolInformation>
   */

  Future<List<SchoolInformation>> getSchoolList() async {
    var childMapList = await getSchools();

    List<SchoolInformation> childInfo = List<SchoolInformation>();

    for (int i = 0; i < childMapList.length; i++) {
      childInfo.add(SchoolInformation.fromMapObject(childMapList[i]));
    }

    return childInfo;
  }

//////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
/////////////////////////////END OF SCHOOL INFORMATION TABLE METHODS//////////
///////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------------------------------


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
/////////////////BEGINNING OF YEAR TABLE METHODS//////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  /**
   * adds years for subject scanned
   */

  void addNewYear(YearInformation yearInformation) async {
    var db_connection = await db;
    String query = 'INSERT INTO $SCHOOL_TABLE VALUES(\'${yearInformation.id}\''
        ',\'${yearInformation.SCHOLAR_YEAR}\',\' ${yearInformation
        .STUDENT_NUMBER}\')';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  /**
   * gets the years per each student attendance
   *
  Future<List<Map<String, dynamic>>> getYears(String studentNumber) async {
    var db_connection = await db;
    var result = await db_connection.query(
        YEAR_TABLE, where: '$STUDENT_NUMBER = ?',
        whereArgs: [studentNumber],
        orderBy: SCHOLAR_YEAR);
    return result;
  }
*/
  /**
   * gets the years in the form of a yearlist object, which is used to populate material objects.

  Future<List<YearInformation>> getYearList() async {
    var childMapList = await getSchools();

    List<YearInformation> yearInfo = List<YearInformation>();

    for (int i = 0; i < childMapList.length; i++) {
      yearInfo.add(YearInformation.fromMapObject(childMapList[i]));
    }

    return yearInfo;
  }
   */

///////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////END OF YEAF INFORMATION LIST///////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//------------------------------------END---------------------------------------

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////////BEGINNING OF MESSAGE TABLE METHODS///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  void insertNewMessage( messageInformation messageinformation) async {
    var db_connection = await db;
    String query = 'INSERT INTO $MESSAGE_TABLE VALUES('
        '\'${messageinformation.id}\''
        ',\'${messageinformation.ARRIVAL_DATE}\''
        ',\'${messageinformation.DEVICE_ID}\','
        '\'${messageinformation.MESSAGE_CONTENT}\','
        '\'${messageinformation.MESSAGE_HEADING}\''
        ',\'${messageinformation.MESSAGE_ID}\' ,'
        '\'${messageinformation.SUBJECT_ID}\','
        '\'${messageinformation.ATTACHMENT_ID}\','
        '\'${messageinformation.EXTENTION}\','
        '\'${messageinformation.NEW_MESSAGE}\','
        '\'${messageinformation.SCHOLAR_YEAR}\','
        '\'${messageinformation.MESSAGE_PRIORITY}\','
        '\'${messageinformation.SET_ID}\')';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  Future<List<Map<String , dynamic>>> getMessage(String subjectID , String Year,String setID ) async{
    var db_connection = await db;
    var result = await db_connection.query(MESSAGE_TABLE,where: '$SCHOLAR_YEAR = ? AND $SUBJECT_ID = ? AND $SET_ID = ?' , whereArgs:[Year,subjectID,setID],orderBy: 'id desc' );
    return result;
  }

  Future<List<messageInformation>> getMessageList(String subjectID , String Year,String setId) async{
    var messageMap = await getMessage(subjectID, Year, setId);

    List<messageInformation> messageList = List<messageInformation>();

    for(int i = 0 ;i < messageMap.length;i++){
      messageList.add(messageInformation.fromMapObject(messageMap[i]));
    }

    return messageList;
  }

  Future<int> getMessageCount() async {
    var database = await db;
    List<Map<String, dynamic>> x = await database.rawQuery(
        'SELECT COUNT(*) FROM $MESSAGE_TABLE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  ////////////////////////BEGINNING OF CONTACT INFORMATION/////////////////////
  /////////////////////////////////////////////////////////////////////////////

  Future<List<Map<String, dynamic>>> getContacts(YearInformation year) async{
    var db_connection = await db;
    var result = await db_connection.query(SUBJECT_TABLE,distinct: true,columns: [SCHOLAR_YEAR,COURSE_ID,SUBJECT_ID,SET_ID] ,where: SCHOLAR_YEAR +'=?'  , whereArgs: [year.SCHOLAR_YEAR]);
    return result;
  }
  
  Future<List<Map<String , dynamic>>> getYears() async{
    var db_connection = await db;
    var result = await db_connection.query(SUBJECT_TABLE ,distinct: true,columns: [SCHOLAR_YEAR]);
    return result;
  }
  Future<List<YearInformation>> getYearList() async{
    var yearMap = await getYears();

    List<YearInformation> yearList = List<YearInformation>();
    for (int i = 0 ; i < yearMap.length; i++){
       yearList.add(YearInformation.fromMapObject(yearMap[i]));
    }

    return yearList;

  }


  Future<List<ContactInformation>> getContactList(YearInformation year ) async{
    var contactMap = await getContacts(year);

    List<ContactInformation> contactList =  List<ContactInformation>();

    for(int i = 0 ; i < contactMap.length;i++){
      contactList.add(ContactInformation.fromMapObject(contactMap[i]));
    }

   return contactList;
  }
  /*
    final String MESSAGE_TABLE = 'MESSAGE_TABLE';
  final String ARRIVAL_DATE = 'ARRIVAL_DATE';
  final String DEVICE_ID = 'DEVICE_ID';
  final String MESSAGE_CONTENT = 'MESSAGE_CONTENT';
  final String MESSAGE_HEADING = 'MESSAGE_HEADING';
  final String MESSAGE_ID = 'MESSAGE_ID';
  final String SUBJECT_ID = 'SUBJECT_ID';
  final String ATTACHMENT_ID = 'ATTACHEMENT_ID';
  final String EXTENTION = 'EXTENTION';
  final String NEW_MESSAGE = 'NEW_MESSAGE';
  final String MESSAGE_PRIORITY = 'MESSAGE_PRIORITY';
   */
  void insertContact( ContactInformation cnt) async {
    var db_connection = await db;
    String query = 'INSERT INTO $SUBJECT_TABLE VALUES('
        '\'${cnt.COURSE_ID}\''
        ',\'${cnt.SUBJECT_ID}\','
        '\'${DateTime.now().year.toString()}\','
        '\'${cnt.SET_ID}\')';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  /*
    // this is for the subject table
  // include student device ID into this table
  final String TEACHER_ID = 'TEACHER_ID';
  final String SUBJECT_TABLE = 'SUBJECT_TABLE';
  final String DEPARTMENT_ID = "DEPARTMENT_ID";
  final String COURSE_ID = 'COURSE_ID';
   */

  void deleteContact(ContactInformation contactInformation 
      , YearInformation yearInformation) async{
    var db_connection = await db;
    db_connection.delete(SUBJECT_TABLE,where: '$SUBJECT_ID = ? '
        'AND $COURSE_ID = ? AND $SCHOLAR_YEAR = ? AND $SET_ID = ?' ,whereArgs: [contactInformation.SUBJECT_ID,contactInformation.COURSE_ID,yearInformation.SCHOLAR_YEAR,contactInformation.SET_ID] );
  }

}
